# Voice-to-Voice Claude Code (v2v-cc)

## 音声会話モードのルール

音声会話中は以下のフローを**必ず**守ること：

### 応答の読み上げ（TTS）
- 応答テキストは **aivis MCP（aivis-speech）** で読み上げる(syncパラメータをtrueにして同期して読み上げる)
- voicemode の `message` パラメータには読み上げテキストを入れない

### 音声の聞き取り（STT）
- `voicemode converse` は **聞き取り専用** で使う
- `message` は空文字列 `""` 、`wait_for_response=true`、`skip_tts=true` を指定

### 会話ループ
1. aivis MCP（aivis-speech）で応答を読み上げる
2. voicemode converse で音声を聞き取る（message="", wait_for_response=true, skip_tts=true）
3. 聞き取った内容を処理し、1に戻る
4. ユーザーが「終わり」「おしまい」「ありがとう」等と言ったらループを終了する
