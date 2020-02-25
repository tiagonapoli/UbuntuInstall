#!/usr/bin/env node
import execa from 'execa'
import { resolve } from 'path'

interface RepoSetup {
  url: string
  callback?: string
}

export function cloneRepo(repoDir: string, { url, callback }: RepoSetup) {
  execa.sync('git', ['clone', url], { cwd: repoDir, stdio: 'inherit' })
  if (callback) {
    const [cmd, ...args] = callback.split(' ')
    execa.sync(cmd, args, { cwd: repoDir })
  }
}

function main(repoDir: string, repos: RepoSetup[]) {
  repos.forEach(repo => {
    cloneRepo(repoDir, repo)
  })
}

if (require.main === module) {
  const REPO_DIR = resolve('~/Documents')
  const repos: RepoSetup[] = JSON.parse(process.argv[2])
  main(REPO_DIR, repos)
}
