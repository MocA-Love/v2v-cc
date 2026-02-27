# v2v-cc - Voice-to-Voice Claude Code

Claude Codeと音声で会話しながらプログラミングできる環境。
マイクで話しかけると音声認識し、Claudeの応答を音声で読み上げる。

## 構成

| コンポーネント | 役割 | リポジトリ |
|---|---|---|
| [VoiceMode MCP (fork)](https://github.com/MocA-Love/voicemode) | 音声認識（STT） | フォーク版。日本語最適化・ハルシネーションフィルター等のパッチ適用済み |
| [aivis-mcp](https://github.com/MocA-Love/aivis-mcp) | 音声合成（TTS） | Aivis Cloud API経由の日本語TTS |
| Claude Code | AI本体 | Anthropic CLI |

## 前提条件

- macOS (Apple Silicon推奨)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) インストール済み
- [aivis-mcp](https://github.com/MocA-Love/aivis-mcp) セットアップ済み
- Python 3.10+
- OpenAI APIキー（クラウドSTT使用時のみ）

## セットアップ

### 1. リポジトリをクローン

```bash
git clone https://github.com/MocA-Love/v2v-cc.git
cd v2v-cc
```

### 2. セットアップスクリプトを実行

```bash
./setup.sh
```

これにより以下が行われる：
- フォーク版VoiceModeをMCPサーバーとして登録
- `~/.voicemode/voicemode.env` に設定テンプレートをコピー

### 3. 設定を編集

```bash
vi ~/.voicemode/voicemode.env
```

ローカルwhisper.cpp（無料）を使う場合はそのままでOK。
OpenAI APIを使う場合は以下を変更：

```
OPENAI_API_KEY=sk-your-key-here
VOICEMODE_PREFER_LOCAL=false
VOICEMODE_STT_BASE_URLS=https://api.openai.com/v1
VOICEMODE_STT_MODEL=gpt-4o-mini-transcribe
```

### 4. パーミッション設定

`~/.claude/settings.json` の `allowlist` に追加：

```json
{
  "permissions": {
    "allow": [
      "mcp__voicemode"
    ]
  }
}
```

### 5. カスタムコマンドの配置

`voice-session.md` を Claude Code のカスタムコマンドとして登録する

## 会話の流れ

1. aivis-mcp でClaudeの応答を読み上げ
2. VoiceMode converse で音声を聞き取り（STTのみ）
3. 聞き取った内容をClaudeが処理し、1に戻る
4. 「終わり」「おしまい」等で終了

## フォーク版VoiceModeの変更点

[オリジナル](https://github.com/mbailey/voicemode)からの変更：

- **`VOICEMODE_STT_MODEL`** 環境変数を追加（STTモデルを設定可能に）
- **`WHISPER_LANGUAGE`** をOpenAI APIに渡すように修正（日本語認識の精度向上）
- **Whisperハルシネーションフィルター** 追加（無音時の誤認識「ご視聴ありがとうございました」等を除去）
- **チャイム音量** を非Bluetoothデバイスで2倍に引き上げ

## 設定リファレンス

全設定項目の詳細は [manual.md](./manual.md) を参照。

## ファイル構成

```
v2v-cc/
├── README.md                 # このファイル
├── CLAUDE.md                 # 音声会話ループのルール（Claude Code用）
├── setup.sh                  # セットアップスクリプト
├── voicemode.env.template    # 設定テンプレート
├── voice-session.md          # 音声会話スラッシュコマンド（/voice-session）
└── manual.md                 # VoiceMode全設定リファレンス
```
