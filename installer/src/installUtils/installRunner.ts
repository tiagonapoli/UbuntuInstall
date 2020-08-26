import boxen from 'boxen'
import chalk from 'chalk'
import execa from 'execa'
import { join } from 'path'
import { InstallStep } from './installMap'

const SCRIPTS_PATH = join(__dirname, '..', 'scripts')

function printScriptStartMessage(stepName: string, scriptPath: string) {
  const msg = [chalk.bold.blue(`Starting to run script ${stepName}`), chalk.dim(`${scriptPath}`)].join('\n')

  const boxOptions: boxen.Options = {
    padding: 1,
    margin: 1,
    borderStyle: boxen.BorderStyle.Round,
    borderColor: 'yellow',
    align: 'center',
  }

  console.log(boxen(msg, boxOptions))
}

interface Flag {
  name: string
  value: string
}

interface Argument {
  type: 'json'
  value: any
}

function createArgs(config: any) {
  let args = []
  if (config.flags) {
    config.flags.forEach(({ name, value }: Flag) => {
      args.push(`-${name}`)
      args.push(`${value}`)
    })
  }

  if (config.args) {
    config.args.forEach(({ type, value }: Argument) => {
      if (type === 'json') {
        args.push(JSON.stringify(value))
      }
    })
  }

  return args
}

export function runInstallStep({ name, scriptPath, config }: InstallStep, baseScriptPath = SCRIPTS_PATH) {
  printScriptStartMessage(name, scriptPath)

  const absoluteScriptPath = join(baseScriptPath, scriptPath)
  const args = config ? createArgs(config) : ''
  let cmd
  if (scriptPath.endsWith('.js')) {
    cmd = process.argv[0]
  } else if (scriptPath.endsWith('.sh')) {
    cmd = '/bin/bash'
  }

  execa.sync(cmd, [absoluteScriptPath, ...args], { stdio: 'inherit', env: process.env })
}
