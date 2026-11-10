#!/usr/bin/env bash
# Source this file at task startup; also safe to execute during installation.
export XDG_DATA_HOME=/workspace/.story-studio-data
export DOUBAO_TTS_SPEAKER_ID=zh_male_liufei_uranus_bigtts
(
  set -euo pipefail
  cd /workspace/story-studio
  studio_python=/workspace/.story-studio-data/story-studio/venv/bin/python
  "$studio_python" -B - <<'PY'
import os
import stat
import subprocess
import sys
sys.path.insert(0, '/workspace/story-studio/scripts')
from pathlib import Path
from voice_settings import load_profile, profile_path

expected = dict(speaker='zh_male_liufei_uranus_bigtts', resource_id='seed-tts-2.0',
                model=None, speech_rate=0, loudness_rate=0)
raw_path = Path('/workspace/.story-studio-data/story-studio/voice.json')
if any(p.is_symlink() for p in (raw_path, *raw_path.parents)):
    raise RuntimeError('Refusing a symlink voice profile')
path = profile_path()
try:
    correct = load_profile() == expected
except (OSError, ValueError):
    correct = False
if not correct:
    subprocess.run([sys.executable, '-B', 'scripts/voice_settings.py', 'configure',
                    '--speaker', expected['speaker'], '--resource-id', expected['resource_id'],
                    '--speech-rate', '0', '--loudness-rate', '0'], check=True)
if stat.S_IMODE(path.stat().st_mode) != 0o600:
    path.chmod(0o600)
assert load_profile() == expected
assert os.access(path, os.R_OK)
assert path == raw_path
print('Liu Fei 2.0 voice profile ready; no speech request sent.')
PY
)
