# How to contribute

We are really glad you're reading this, because we need volunteer developers to help this project come to fruition.

We want you working on things you're excited about.

You can contact us by mail agorakube@ilki.fr or you can join our AGORAKUBE's Github Discussions community for discussion and ask questions : [AGORAKUBE's Discussions](https://github.com/ilkilab/agorakube/discussions)

Channels :
- **#general** - For general purpose (news, events...)
- **#developpers** - For people who contribute to Agorakube by developing features
- **#end-users** - For end users who want to give us feedbacks
- **#random** - As its name suggests, for random discussions :)

## Code Overview

See below Agorakube code architecture:

* .github/ - Contains all Github Configurations including:
    * workflows/* - Contains 'GitHub Actions' workflows
    * ISSUE_TEMPLATE/* - Contains all Isuues Templates display when we create Issues
* actions/* - Contains a folder for each custom GitHubActions.
    * ansible-lint/* - Contains all sources used for testing Anisble code in GithubAction using GitHub Actions
* docs/* - Contains all the official Agorakube documentation.
    * translations/* - Contains a transation in a specific language of the Agorakube documentation
* group_vars/all.yaml - Contains all defaults parameters used in Agorakube Deployments
* images/* - Contains images used in the Agorakube Doc
* roles/* - Contains all the Ansible roles used to install Agorakube. Each role install/manage a specific component
* test/inventory - Contains a test inventory file used by "test_lab"
* labs/* - Contains test labs used for Agorakube development/test. This test labs use Vagrant/virtualBox
* tools/* - Contains folders for some specific management actions
    * etcd - Contains some playbooks for ETCD management lagorakube backup/restore etcd
* hosts - Inventory file that define your Agorakube Cluster
* agorakube.yaml - Ansible Playbook used to deploy Agorakube

## Set up a local test lab

You can set a local test lab for Agorakube using Vagrant and VirtualBox.
See [LOCAL_ENVIRONMENT](../LOCAL_ENVIRONMENT.md) for more details.

## Testing

We use Ansible-lint with GithuActions to test Ansible code quality.


## Sample needs

All contributions are welcome :)

Here is a non-exhaustive list of contributions needed for this project:

* Documentation
* Add features lagorakube new runtime support, new Ingress Controller installation, new CNI plugin, etc...
* Improve the code quality
* ...

## Submitting changes

Please send a [GitHub Pull Request to AGORAKUBE-CORE](https://github.com/ilkilabs/agorakube) with a clear list of what you've done (read more about [pull requests](https://help.github.com/en/articles/about-pull-requests/)). When you send a pull request, we will love you forever if your code stay idempotent. We can always use more test coverage. Please follow our coding conventions (below) and make sure all of your commits are atomic (one feature per commit).

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look lagorakube this:

    $ git commit -m "A brief summary of the commit
    >
    > A paragraph describing what changed and its impact."

## Coding conventions

Start reading our code and you'll get the hang of it. We optimize for readability:

  * We indent using two spaces (soft tabs)
  * We use task's name as comment in Ansible Playbooks. All names have to explicit the task goal.
  * This is open source software. Consider the people who will read your code, and make it look nice for them. It's sort of lagorakube driving a car: Perhaps you love doing donuts when you're alone, but with passengers the goal is to make the ride as smooth as possible.
  * You can use common tools lagorakube "VisualStudioCode", or "Atom" to make your Ansible code !


Thanks,

Ilkilabs team
