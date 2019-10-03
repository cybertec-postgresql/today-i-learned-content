---
date: 2019-09-18
title: Get Pull Request Approval with the GitHub API (v4)
author: sascha.lampalzer@cybertec.at
tags: ["github", "graphql", "typescript"] # max. 10 tags; lowercase; dash-separated
description: "Natively the GitHub API does not provide a way to get a pull request's approval status. Here's a workaround." # max. 300 chars.
---

Natively, the GitHub API does not provide a way to obtain a pull request's approval status. Here's a workaround.

It is necessary to compare the date of the newest commit and the date of last approval, because new commits automatically invalidate any approvals (default behavior, can be configured).

```typescript
import { graphql } from "@octokit/graphql"
import { Repository, PullRequest } from "./types"

const query = graphql.defaults({
  headers: {
    authorization: `token ${process.env.GITHUB_TOKEN}`,
  },
})

function isApproved(pr: PullRequest): Boolean {
  if (!pr.reviews.edges.length) return false

  const latestCommit = new Date(pr.commits.edges[0].node.commit.authoredDate)
  const latestApproval = new Date(pr.reviews.edges[0].node.updatedAt)

  return latestApproval > latestCommit
}

async function getAllApprovedPullRequests(): Promise<PullRequest[] | null> {
  const queryResult: any = await query(`{
      repository(owner: "cybertec-postgresql", name: "today-i-learned-content") {
        pullRequests(last: 25, states: OPEN) {
          edges {
            node {
              title
              number
              reviews(states: APPROVED, last: 1) {
                edges {
                  node {
                    updatedAt
                  }
                }
              }
              commits(last: 1) {
                edges {
                  node {
                    commit {
                      authoredDate
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  `)

  const repo: Repository = queryResult.repository

  if (!repo.pullRequests.edges) return null

  let pullRequests: PullRequest[] = repo.pullRequests.edges
    .map(edge => edge.node)
    .filter(pr => isApproved(pr))

  return pullRequests
}
```
