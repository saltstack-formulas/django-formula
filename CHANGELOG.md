# Changelog

## [0.5.1](https://github.com/saltstack-formulas/django-formula/compare/v0.5.0...v0.5.1) (2022-02-12)


### Code Refactoring

* **salt-lint:** fix violations ([f73f9ca](https://github.com/saltstack-formulas/django-formula/commit/f73f9cac2d22a0516b44b0b319481964997bc028))


### Continuous Integration

* update linters to latest versions [skip ci] ([6ebf288](https://github.com/saltstack-formulas/django-formula/commit/6ebf288fcc7cb837f8d9454967b37df73503d427))
* **3003.1:** update inc. AlmaLinux, Rocky & `rst-lint` [skip ci] ([8cbb4a6](https://github.com/saltstack-formulas/django-formula/commit/8cbb4a6f1721bed6b3f7ec50ea71b6256250d27e))
* **commitlint:** ensure `upstream/master` uses main repo URL [skip ci] ([85cb8f0](https://github.com/saltstack-formulas/django-formula/commit/85cb8f0d203cbd5f6818dbfe7c55586408027ba0))
* **gemfile:** allow rubygems proxy to be provided as an env var [skip ci] ([c8603c9](https://github.com/saltstack-formulas/django-formula/commit/c8603c9fc7a606f2cf161e6df8b2f8d7cbcb1536))
* **gemfile:** restrict `train` gem version until upstream fix [skip ci] ([0abff57](https://github.com/saltstack-formulas/django-formula/commit/0abff57230106983efc1b2a15adf8f5a3da74e64))
* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([b6a4ad6](https://github.com/saltstack-formulas/django-formula/commit/b6a4ad6a2b54141ca4f76da15eba5a8902a4b829))
* **gemfile+lock:** use `ssf` customised `inspec` repo [skip ci] ([228e51b](https://github.com/saltstack-formulas/django-formula/commit/228e51bd32755ee05b5cd6b86c45bbe9b101ec3b))
* **gemfile+lock:** use `ssf` customised `kitchen-docker` repo [skip ci] ([e293044](https://github.com/saltstack-formulas/django-formula/commit/e293044b1a7cc9bda4f4fd8447f70df4b820df27))
* **gitlab-ci:** add `rubocop` linter (with `allow_failure`) [skip ci] ([aee1b5d](https://github.com/saltstack-formulas/django-formula/commit/aee1b5dcf88466a3aaa4f1429c8f180a79bc7292))
* **gitlab-ci:** use GitLab CI as Travis CI replacement ([b797489](https://github.com/saltstack-formulas/django-formula/commit/b797489e4cd2ee20925d485c9188698a2bdaedda))
* **kitchen:** avoid using bootstrap for `master` instances [skip ci] ([894e51e](https://github.com/saltstack-formulas/django-formula/commit/894e51e48444d4e1ab0349eb82968c2aa6d06318))
* **kitchen:** move `provisioner` block & update `run_command` [skip ci] ([dcbcb96](https://github.com/saltstack-formulas/django-formula/commit/dcbcb96f81e19a93ec3515d16341579e16d2cabc))
* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([6496040](https://github.com/saltstack-formulas/django-formula/commit/649604030f5de1e5aa65032edff472aee3c8026d))
* **kitchen+ci:** update with `3004` pre-salted images/boxes [skip ci] ([39b44f7](https://github.com/saltstack-formulas/django-formula/commit/39b44f76819133ce8d71faa549b99cfaf8bf6d0d))
* **kitchen+ci:** update with latest `3003.2` pre-salted images [skip ci] ([dac2516](https://github.com/saltstack-formulas/django-formula/commit/dac25162c496e3a0489009b8be58270a794940f2))
* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] ([2f29575](https://github.com/saltstack-formulas/django-formula/commit/2f29575658501c40c9b433ba1052b13e4b4fbd4f))
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] ([8de998a](https://github.com/saltstack-formulas/django-formula/commit/8de998ae05369fe2d0251ea9002065c34a04fa02))
* **kitchen+gitlab:** adjust matrix to add `3003` [skip ci] ([247495a](https://github.com/saltstack-formulas/django-formula/commit/247495a9d02bc4d5159ed6d432c833f6c32ff552))
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] ([7fdcc68](https://github.com/saltstack-formulas/django-formula/commit/7fdcc6809e0ede6f9b22e7700920303a53c07333))
* **kitchen+gitlab:** update for new pre-salted images [skip ci] ([946d035](https://github.com/saltstack-formulas/django-formula/commit/946d035b596957e28de75f3a27a686240f452303))
* add `arch-master` to matrix and update `.travis.yml` [skip ci] ([2958879](https://github.com/saltstack-formulas/django-formula/commit/2958879d04794596715d93acb2f1d8ec833b2519))
* add Debian 11 Bullseye & update `yamllint` configuration [skip ci] ([e5f295d](https://github.com/saltstack-formulas/django-formula/commit/e5f295dd4cd06ebe953622cbf588a56ca356c49e))
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] ([dca4e26](https://github.com/saltstack-formulas/django-formula/commit/dca4e2615319d860f13f97f1485f88eecb668137))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([d098b4b](https://github.com/saltstack-formulas/django-formula/commit/d098b4b40e6f88ec5e69ffe02ab876bb41e850ac))
* **pre-commit:** add to formula [skip ci] ([acf5bb5](https://github.com/saltstack-formulas/django-formula/commit/acf5bb5bb7ee692964a673e0fcacd1e40558a648))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([058a5d1](https://github.com/saltstack-formulas/django-formula/commit/058a5d1059895d751a0b6d9d438474f2535e6a10))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([e0e5b69](https://github.com/saltstack-formulas/django-formula/commit/e0e5b69627433d23fdfd8b3386a2e84dc95cae2b))
* **pre-commit:** update hook for `rubocop` [skip ci] ([56b44ca](https://github.com/saltstack-formulas/django-formula/commit/56b44ca5c8266f06f44280dffa9d39eefee17e71))
* **travis:** add notifications => zulip [skip ci] ([047e6cb](https://github.com/saltstack-formulas/django-formula/commit/047e6cb2224268d8d202caed7dca7f5260b5af08))
* **travis:** quote pathspecs used with `git ls-files` [skip ci] ([b3d3503](https://github.com/saltstack-formulas/django-formula/commit/b3d3503715a786682d213625385d3a4f204ab8d8))
* **travis:** run `shellcheck` during lint job [skip ci] ([877cab5](https://github.com/saltstack-formulas/django-formula/commit/877cab5317a51de9e618fac56d77d5710163d8d4))
* **travis:** use `major.minor` for `semantic-release` version [skip ci] ([d9ad891](https://github.com/saltstack-formulas/django-formula/commit/d9ad891a49508842cfe241e5ab4e11086c89c90f))
* **travis:** use default matrix after `centos-6` image fix ([3c7b45a](https://github.com/saltstack-formulas/django-formula/commit/3c7b45a264cb16359926bf07a17bb2cd37e71be5))
* **workflows/commitlint:** add to repo [skip ci] ([ea8f09e](https://github.com/saltstack-formulas/django-formula/commit/ea8f09e07b3cf7d022c1ff6e51dee455c880937d))


### Tests

* standardise use of `share` suite & `_mapdata` state [skip ci] ([56cb1ec](https://github.com/saltstack-formulas/django-formula/commit/56cb1ec91b9767c01b4ec8ed820b6ddcb0599a25))

# [0.5.0](https://github.com/saltstack-formulas/django-formula/compare/v0.4.0...v0.5.0) (2019-11-25)


### Bug Fixes

* **yamllint:** fix all errors ([773aab8](https://github.com/saltstack-formulas/django-formula/commit/773aab892cae3f69764514c776bc93209750007b))


### Documentation

* **changelog:** update according to standard structure ([07eec72](https://github.com/saltstack-formulas/django-formula/commit/07eec72c95f4eddde22f4720f92cee8557c60438))
* **readme:** modify according to standard structure ([94e3e89](https://github.com/saltstack-formulas/django-formula/commit/94e3e89716f42bd11bd498f18bc92aa9e13b7a4a))
* **readme:** move to `docs/` directory ([4db7d05](https://github.com/saltstack-formulas/django-formula/commit/4db7d05fe06dd91f9e54d5a870c7d0d8ae428961))


### Features

* **semantic-release:** implement for this formula ([77bc3a9](https://github.com/saltstack-formulas/django-formula/commit/77bc3a95cfb670a7b9b1cff3002b27aa42bb1d38))

## [v0.4.0](https://github.com/saltstack-formulas/django-formula/tree/v0.4.0) (2015-06-22)
**Merged pull requests:**

- Fix Typo in Word Settings [\#5](https://github.com/saltstack-formulas/django-formula/pull/5) ([rspt](https://github.com/rspt))
- Change states to use short-dec style [\#4](https://github.com/saltstack-formulas/django-formula/pull/4) ([whiteinge](https://github.com/whiteinge))
- Update README.rst [\#3](https://github.com/saltstack-formulas/django-formula/pull/3) ([ghost](https://github.com/ghost))
- Some fixes to make this formula work on Ubuntu 14.04 LTS [\#2](https://github.com/saltstack-formulas/django-formula/pull/2) ([terminalmage](https://github.com/terminalmage))
