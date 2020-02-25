import { mkdirpSync, removeSync, pathExistsSync } from 'fs-extra'
import os from 'os'
import { join } from 'path'
import { cloneRepo } from './repositorySetup'

const TMP_DIR = join(os.tmpdir(), 'repositorySetupTest')

beforeEach(() => {
  removeSync(TMP_DIR)
  mkdirpSync(TMP_DIR)
})

test('Repo is cloned correctly', () => {
  cloneRepo(TMP_DIR, {
    url: 'git@github.com:tiagonapoli/competitiveProgramming.git',
    callback: '',
  })
  expect(pathExistsSync(join(TMP_DIR, 'competitiveProgramming'))).toBe(true)
})

test('Callback is called on success', () => {
  cloneRepo(TMP_DIR, {
    url: 'git@github.com:tiagonapoli/competitiveProgramming.git',
    callback: 'mv competitiveProgramming newName',
  })
  expect(pathExistsSync(join(TMP_DIR, 'competitiveProgramming'))).toBe(false)
  expect(pathExistsSync(join(TMP_DIR, 'newName'))).toBe(true)
})
