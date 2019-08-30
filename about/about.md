## About TIL@Cybertec

Today I learned is a concept we first came across when visiting [https://til.hashrocket.com/](https://til.hashrocket.com/). It is meant to be a collection of short posts about stuff, that we found out and that could be helpful to others.

We have taken this concept and re-created our own version using the [Gatsby Static Site Generator](https://www.gatsbyjs.org/), to achieve maximum performance (and even offline capability!), all in order to provide a great and simple user experience.

### Content Automation

It shouldn't come as a surprise, that providing daily content is a hard and daunting task, so we chose a different approach: Instead of releasing all the posts at once we automated our deployment and proofreading process. Daily at 12:00 GMT+0 a [GitHub Action](https://github.com/cybertec-postgresql/today-i-learned-content/actions) searches through all the approved pull requests on our [Content Repository](https://github.com/cybertec-postgresql/today-i-learned-content/pulls), selects a random one and publishes it. This in turn also triggers our automated build and deployment process.
