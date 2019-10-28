# How to contribute

I'm really glad you're reading this, because we need volunteer developers to help this project come to fruition.

We want you working on things you're excited about.

You can contact us by mail  agorakube@ilki.fr

## Set up a local test lab

You can set a local test lab for Agorakube using Vagrant and VirtualBox.
See [LOCAL_ENVIRONMENT](../LOCAL_ENVIRONMENT.md) for more details.

## Testing

Tests are not automated yet.


## Sample needs

All contributions are welcome :)

Here is a non-exhaustive list of contributions needed for this project:

* Documentation
* Add features like new runtime support, new Ingress Controller installation, new CNI plugin, etc...
* Improve the code quality
* ...

## Submitting changes

Please send a [GitHub Pull Request to AgoraKube](https://github.com/ilkilab/agorakube) with a clear list of what you've done (read more about [pull requests](https://help.github.com/en/articles/about-pull-requests/)). When you send a pull request, we will love you forever if your code stay idempotent. We can always use more test coverage. Please follow our coding conventions (below) and make sure all of your commits are atomic (one feature per commit).

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

    $ git commit -m "A brief summary of the commit
    >
    > A paragraph describing what changed and its impact."

## Coding conventions

Start reading our code and you'll get the hang of it. We optimize for readability:

  * We indent using two spaces (soft tabs)
  * We use task's name as comment in Ansible Playbooks. All names have to explicit the task goal.
  * This is open source software. Consider the people who will read your code, and make it look nice for them. It's sort of like driving a car: Perhaps you love doing donuts when you're alone, but with passengers the goal is to make the ride as smooth as possible.
  * You can use common tools like "VisualStudioCode", or "Atom" to make your Ansible code !


Thanks,

Ilki team
