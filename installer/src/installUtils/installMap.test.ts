import { generateInstallSteps, InstallMapNode, InstallStep } from './installMap'

interface TreeSample {
  tree: InstallMapNode
  config: any
}

interface ErrorSample extends TreeSample {
  throws: true
}

interface SuccessSample extends TreeSample {
  res: InstallStep[]
}

const samples: Array<ErrorSample | SuccessSample> = [
  {
    tree: {
      name: 'a',
      scriptPath: 'a.sh',
      configSubPath: 'a',
      children: [
        { name: 'b', scriptPath: 'b.sh', configSubPath: 'b' },
        { name: 'c', scriptPath: 'c.sh' },
      ],
    },
    config: {
      a: {
        b: 'b',
        c: 'c',
      },
    },
    res: [
      { name: 'a:b', scriptPath: 'b.sh', config: 'b' },
      { name: 'a:c', scriptPath: 'c.sh' },
    ],
  },

  {
    throws: true,
    tree: {
      name: 'a',
      scriptPath: 'a.sh',
      configSubPath: 'a',
      children: [{ name: 'b', scriptPath: 'b.sh', configSubPath: 'b' }],
    },
    config: {
      a: {},
    },
  },
]

test.each(samples)('Test %#', sample => {
  const { config, tree } = sample
  if ((sample as ErrorSample).throws) {
    expect(() => generateInstallSteps(tree, config)).toThrowErrorMatchingSnapshot()
  } else {
    expect(generateInstallSteps(tree, config)).toEqual((sample as SuccessSample).res)
  }
})
