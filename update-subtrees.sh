#!/bin/sh

git subtree pull --prefix .config/awesome/awesome-wm-widgets https://github.com/streetturtle/awesome-wm-widgets master --squash
git subtree pull --prefix .config/awesome/battery-widget https://github.com/deficient/battery-widget master --squash
git subtree pull --prefix .config/awesome/calendar https://github.com/deficient/calendar master --squash
git subtree pull --prefix .config/awesome/freedesktop https://github.com/lcpz/awesome-freedesktop master --squash
git subtree pull --prefix .config/awesome/json https://github.com/rxi/json.lua master --squash
git subtree pull --prefix .config/awesome/lain https://github.com/lcpz/lain master --squash
git subtree pull --prefix .config/awesome/vicious https://github.com/vicious-widgets/vicious master --squash
git subtree pull --prefix .config/awesome/layout-machi https://github.com/xinhaoyuan/layout-machi master --squash

git subtree pull --prefix .tmux/plugins/tpm https://github.com/tmux-plugins/tpm master --squash

git subtree pull --prefix zsh/zinit https://github.com/zdharma-continuum/zinit main --squash
