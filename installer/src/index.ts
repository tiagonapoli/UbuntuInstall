import { mkdirpSync, readJSONSync, writeJSONSync, pathExistsSync } from 'fs-extra'
import { dirname, join } from 'path'
import { generateInstallSteps, InstallMapNode, InstallStep } from './installUtils/installMap'
import { runInstallStep } from './installUtils/installRunner'

const STEPS_PATH = join(__dirname, '../..', 'tmp', 'steps.json')
const CONFIG_PATH = join(__dirname, '../..', 'config')

function readSteps(): InstallStep[] {
  if (pathExistsSync(STEPS_PATH)) {
    return readJSONSync(STEPS_PATH)
  }

  mkdirpSync(dirname(STEPS_PATH))
  const installTree: InstallMapNode = {
    name: '',
    children: readJSONSync(join(CONFIG_PATH, 'installTree.json')) as InstallMapNode[],
    configSubPath: 'root',
  }
  const config = { root: readJSONSync(join(CONFIG_PATH, 'config.json')) }
  const steps = generateInstallSteps(installTree, config)

  writeJSONSync(STEPS_PATH, steps)
  return steps
}

function main() {
  let steps = readSteps()
  while (steps.length > 0) {
    const step = steps.shift()
    try {
      runInstallStep(step)
      writeJSONSync(STEPS_PATH, steps)
    } catch (err) {
      console.log(err)
      process.exit(1)
    }
  }
}

main()
