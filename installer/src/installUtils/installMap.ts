
export interface InstallMapNode {
  name: string
  children?: InstallMapNode[]
  scriptPath?: string
  configSubPath?: string
}

export interface InstallStep {
  name: string
  scriptPath: string
  config?: any
}

export function generateInstallSteps(
  node: InstallMapNode,
  config: any,
  configPath = '',
  treePath = ''
): InstallStep[] {
  const { name, scriptPath, children, configSubPath } = node

  const resultTreePath = treePath ? `${treePath}:${name}` : name
  const resultConfigPath = configPath ? `${configPath}.${configSubPath}` : configSubPath

  if (configSubPath && !config?.[configSubPath]) {
    throw new Error(`Missing config for ${resultTreePath}. Needs ${resultConfigPath} key on config.`)
  }

  if (!children || children.length === 0) {
    return [
      {
        name: resultTreePath,
        scriptPath,
        ...(configSubPath ? { config: config[configSubPath] } : null),
      },
    ]
  }

  let res: InstallStep[] = []
  children.forEach(childNode => {
    res.push(
      ...generateInstallSteps(childNode, configSubPath ? config[configSubPath] : null, resultConfigPath, resultTreePath)
    )
  })
  return res
}
