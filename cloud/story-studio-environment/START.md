# Story Studio cloud startup

Use the existing /workspace/story-studio checkout and installed dependencies. Each task is isolated; do not create a Git worktree unless explicitly requested. No web service is needed. Do not reinstall dependencies or call paid synthesis during initialization.

These files do not execute automatically merely because they exist in GitHub. START.md is guidance, not a shell hook. Register it in Codex Cloud start_skill, or explicitly instruct the agent to follow this file at the start of each task.

After committing these three files under cloud/story-studio-environment, run in the SAME shell as subsequent voice commands:

```bash
source /workspace/story-studio/cloud/story-studio-environment/ensure-voice.sh || exit
python3 -B /workspace/story-studio/scripts/voice_settings.py check
```

The current local fallback is /workspace/story-studio-environment/ensure-voice.sh. Future tasks must check out a commit containing these files. Publishing a new Git branch does not update main.

The script exports XDG_DATA_HOME=/workspace/.story-studio-data and DOUBAO_TTS_SPEAKER_ID=zh_male_liufei_uranus_bigtts only in the current shell and its children. Separate agent commands need to source it again unless platform variables are corrected. It reads DOUBAO_TTS_SPEECH_RATE when set; otherwise speech_rate defaults to -10. Overrides must be integers in -50..100; empty or invalid values fail before changing the profile.

In environment settings persist XDG_DATA_HOME=/workspace/.story-studio-data and replace DOUBAO_TTS_SPEAKER_ID with zh_male_liufei_uranus_bigtts. Preserve DOUBAO_TTS_API_KEY, DOUBAO_TTS_RESOURCE_ID=seed-tts-2.0, network rules and other valid settings. Optionally persist DOUBAO_TTS_SPEECH_RATE=-10 to make the intended rate explicit; leaving it unset uses the same default. Never commit voice.json or credentials.

For managed startup, preserve the existing install_script and append bash /workspace/story-studio/cloud/story-studio-environment/install.sh. This helper only initializes voice and checks existing dependencies. Add the source-and-check commands above to start_skill. Review, save and publish through environment settings; neither saved files nor a draft prove publication or fresh-task inheritance.

The official voice_settings.py configure creates or repairs /workspace/.story-studio-data/story-studio/voice.json only when needed. The profile is speaker zh_male_liufei_uranus_bigtts, resource_id seed-tts-2.0, speech_rate -10 by default, loudness_rate 0, model null; permissions 0600. Correct configuration is not rewritten, including on repeated initialization. New videos using this initialized profile inherit the configured rate; existing generated audio is unchanged. No key is stored by initialization.

Keep Python, FFmpeg, Coli, pyJianYingDraft and other dependencies unchanged. Use /workspace/.story-studio-data/story-studio/venv/bin/python for media commands. Draft output remains /workspace/story-studio-outputs/drafts. Linux initialization does not validate Jianying desktop playback.
