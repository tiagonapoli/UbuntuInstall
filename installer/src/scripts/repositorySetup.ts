#!/usr/bin/env node
import execa from 'execa'
import { homedir } from 'os'
import { join } from 'path'

interface RepoSetup {
  url: string
  callback?: string
}

export function cloneRepo(repoDir: string, { url, callback }: RepoSetup) {
  execa.commandSync(`/usr/bin/git clone ${url}`, { cwd: repoDir, stdio: 'inherit' })
  if (callback) {
    execa.commandSync(callback, { cwd: repoDir, shell: true })
  }
}

function main(repoDir: string, repos: RepoSetup[]) {
  repos.forEach(repo => {
    cloneRepo(repoDir, repo)
  })
}

if (require.main === module) {
  const REPO_DIR = join(homedir(), 'Documents')
  const repos: RepoSetup[] = JSON.parse(process.argv[2])
  main(REPO_DIR, repos)
}
