#!/usr/bin/env node
import execa from 'execa'
import { writeJSONSync } from 'fs-extra'
import { join } from 'path'
import { homedir } from 'os'

interface VSCodeSetup {
  settings?: any
  keyBindings?: any
  extensionsToInstall?: string[]
}

const CODE_USER_CONFIG_PATH = join(homedir(), '.config/Code/User')
const SETTINGS_PATH = join(CODE_USER_CONFIG_PATH, 'settings.json')
const KEYBINDINGS_PATH = join(CODE_USER_CONFIG_PATH, 'keybindings.json')

export function installExtension(extension: string) {
  return execa.sync('code', ['--install-extension', extension])
}

export function setSettings(settingsPath: string, settings: any) {
  return writeJSONSync(settingsPath, settings)
}

export function setKeyBindings(keyBindingsPath: string, keyBindings: any) {
  return writeJSONSync(keyBindingsPath, keyBindings)
}

function main({ settings, keyBindings, extensionsToInstall }: VSCodeSetup) {
  if (settings) {
    setSettings(SETTINGS_PATH, settings)
  }

  if (keyBindings) {
    setKeyBindings(KEYBINDINGS_PATH, keyBindings)
  }

  const extensions = extensionsToInstall ?? []
  extensions.forEach(extension => {
    installExtension(extension)
  })
}

if (require.main === module) {
  const vscodeSetup = JSON.parse(process.argv[2])
  main(vscodeSetup)
}
