#!/usr/bin/env bash
set -euo pipefail
studio_env_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd /workspace/story-studio
export XDG_DATA_HOME=/workspace/.story-studio-data
export npm_config_cache=/workspace/.story-studio-data/npm-cache
export PIP_CACHE_DIR=/workspace/.story-studio-data/pip-cache
# This environment already contains dependencies. Never reinstall them here.
source "$studio_env_dir/ensure-voice.sh"
bash scripts/bootstrap.sh check --features draft,asr,images,tts
python3 -B scripts/setup_dependencies.py check --features draft,asr,images,tts
