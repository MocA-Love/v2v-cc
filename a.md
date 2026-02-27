# VoiceMode MCP 設定リファレンス

## Whisper モデル一覧（OpenAI API）

| モデル | 精度 | 費用 | 特徴 |
|---|---|---|---|
| `gpt-4o-transcribe` | 最高 | $0.006/分 | LLMベース。文脈理解でプログラミング用語に強い |
| `gpt-4o-mini-transcribe` | 高 | $0.003/分 | 上記の軽量版。コスト半分 |
| `whisper-1` | 中〜高 | $0.006/分 | 従来型 |

## ローカル Whisper モデル一覧（whisper.cpp）

完全無料・オフライン。`VOICEMODE_WHISPER_MODEL` で指定。

| モデル | サイズ | メモリ | 日本語精度 | 速度(Apple Silicon) | 特徴 |
|---|---|---|---|---|---|
| `tiny` | 75 MB | ~273 MB | 低 | 最速 | テスト用 |
| `base` | 141 MB | ~388 MB | 低〜中 | 速い | デフォルト。日本語には力不足 |
| `small` | 466 MB | ~852 MB | 中 | 中程度 | 英語ならそこそこ |
| `medium` | 1.5 GB | ~1.5 GB | 高 | やや遅い | 日本語実用ライン |
| `large-v2` | 2.9 GB | ~3.1 GB | 高 | 遅い | 旧最上位 |
| `large-v3` | 2.9 GB | ~3.1 GB | 最高 | 遅い | 最高精度 |
| `large-v3-turbo` | 1.6 GB | ~1.6 GB | 高（v3並み） | v3の4倍速 | **日本語のベストバランス** |

日本語特化:

| モデル | 特徴 |
|---|---|
| `kotoba-whisper-v1.0` | ReazonSpeech日本語データで訓練。日本語特化だが専門用語に弱い |

## 全設定項目一覧

設定ファイル: `~/.voicemode/voicemode.env`（グローバル） / `.voicemode.env`（プロジェクト）

### コア設定
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_BASE_DIR` | `~/.voicemode` | データ保存先ルート |
| `VOICEMODE_MODELS_DIR` | `~/.voicemode/models` | モデル保存先 |
| `VOICEMODE_DEBUG` | `false` | デバッグモード（`trace`で最詳細） |
| `VOICEMODE_VAD_DEBUG` | `false` | VADデバッグログ |
| `VOICEMODE_SAVE_ALL` | `false` | 全音声・文字起こし保存 |
| `VOICEMODE_SAVE_AUDIO` | `false` | 音声ファイル保存 |
| `VOICEMODE_SAVE_TRANSCRIPTIONS` | `false` | 文字起こしファイル保存 |
| `VOICEMODE_SKIP_TTS` | `false` | TTS無効化（STTのみ） |
| `VOICEMODE_METRICS_LEVEL` | `summary` | 出力の詳細度（`minimal`/`summary`/`verbose`） |
| `VOICEMODE_AUDIO_FEEDBACK` | `true` | チャイム音ON/OFF |
| `VOICEMODE_SOUNDFONTS_ENABLED` | `true` | ツール使用時の効果音 |

### ツール制御
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_TOOLS_ENABLED` | `converse,service` | 有効にするツール（ホワイトリスト） |
| `VOICEMODE_TOOLS_DISABLED` | なし | 無効にするツール（ブラックリスト） |

### プロバイダー設定
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_TTS_BASE_URLS` | `localhost:8880,api.openai.com` | TTSエンドポイント（カンマ区切り、順にフェイルオーバー） |
| `VOICEMODE_STT_BASE_URLS` | `localhost:2022,api.openai.com` | STTエンドポイント（同上） |
| `VOICEMODE_STT_PROMPT` | 空 | Whisperの語彙バイアス用プロンプト |
| `VOICEMODE_VOICES` | `af_sky,alloy` | 優先音声リスト |
| `VOICEMODE_TTS_MODELS` | `tts-1,tts-1-hd,gpt-4o-mini-tts` | TTSモデルリスト |
| `VOICEMODE_PREFER_LOCAL` | `true` | ローカルプロバイダー優先 |
| `VOICEMODE_ALWAYS_TRY_LOCAL` | `true` | ローカルを常に試行 |
| `VOICEMODE_AUTO_START_KOKORO` | `false` | Kokoro自動起動 |
| `VOICEMODE_TTS_SPEED` | なし | TTS速度（0.25〜4.0） |

### Whisper設定
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_WHISPER_MODEL` | `base` | ローカルWhisperモデル |
| `VOICEMODE_WHISPER_PORT` | `2022` | ローカルWhisperサーバーポート |
| `VOICEMODE_WHISPER_LANGUAGE` | `auto` | 認識言語（`ja`, `en`等） |
| `VOICEMODE_WHISPER_THREADS` | 自動 | 処理スレッド数 |
| `VOICEMODE_WHISPER_MODEL_PATH` | `~/.voicemode/services/whisper/models` | モデルパス |

### Kokoro TTS設定
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_KOKORO_PORT` | `8880` | Kokoroサーバーポート |
| `VOICEMODE_KOKORO_MODELS_DIR` | `~/.voicemode/models/kokoro` | モデルディレクトリ |
| `VOICEMODE_KOKORO_DEFAULT_VOICE` | `af_sky` | デフォルト音声 |
| `VOICEMODE_KOKORO_MAX_REQUESTS` | `25` | メモリリーク対策の再起動閾値 |

### 録音・VAD設定
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_VAD_AGGRESSIVENESS` | `3` | VAD感度 0-3（高いほど厳しく非音声を検出） |
| `VOICEMODE_SILENCE_THRESHOLD_MS` | `1000` | 無音後の録音停止までのms |
| `VOICEMODE_MIN_RECORDING_DURATION` | `0.5` | 最短録音秒数 |
| `VOICEMODE_INITIAL_SILENCE_GRACE_PERIOD` | `1.0` | VAD開始前の猶予秒数 |
| `VOICEMODE_DEFAULT_LISTEN_DURATION` | `120.0` | 最大録音秒数 |
| `VOICEMODE_DISABLE_SILENCE_DETECTION` | `false` | 無音検出を完全無効化 |
| `VOICEMODE_CHIME_LEADING_SILENCE` | `0.1` | チャイム前の無音（Bluetooth対応） |
| `VOICEMODE_CHIME_TRAILING_SILENCE` | `0.2` | チャイム後の無音 |

### 音声フォーマット
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_AUDIO_FORMAT` | `pcm` | グローバル音声形式 |
| `VOICEMODE_TTS_AUDIO_FORMAT` | `pcm` | TTS用形式 |
| `VOICEMODE_STT_AUDIO_FORMAT` | `mp3` | STTアップロード形式 |
| `VOICEMODE_OPUS_BITRATE` | `32000` | Opusビットレート |
| `VOICEMODE_MP3_BITRATE` | `64k` | MP3ビットレート |

### ストリーミング
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_STREAMING_ENABLED` | `true` | ストリーミング再生 |
| `VOICEMODE_STREAM_CHUNK_SIZE` | `4096` | チャンクサイズ(bytes) |
| `VOICEMODE_STREAM_BUFFER_MS` | `150` | 再生開始前バッファ(ms) |
| `VOICEMODE_STREAM_MAX_BUFFER` | `2.0` | 最大バッファ(秒) |

### フレーズ検出
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_REPEAT_PHRASES` | `repeat,say that again,...` | リピート要求フレーズ |
| `VOICEMODE_WAIT_PHRASES` | `wait` | 一時停止フレーズ |
| `VOICEMODE_WAIT_DURATION` | `60.0` | 一時停止秒数 |

### 発音ルール
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_PRONUNCIATION_ENABLED` | `true` | 発音ミドルウェア |
| `VOICEMODE_PRONOUNCE` | JSON/API等のルール | TTS/STT方向の置換ルール |
| `VOICEMODE_PRONUNCIATION_LOG_SUBSTITUTIONS` | `false` | 置換ログ |

### Think Out Loud（実験的）
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_THINK_OUT_LOUD` | `false` | 多声思考モード |
| `VOICEMODE_THINKING_VOICES` | 各役割に音声割当 | 役割ごとの音声マッピング |
| `VOICEMODE_THINKING_STYLE` | `sequential` | `sequential`/`debate`/`chorus` |

### Conch（マルチエージェント調整）
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_CONCH_ENABLED` | `true` | 発言権制御システム |
| `VOICEMODE_CONCH_TIMEOUT` | `60` | 発言権待ち最大秒数 |
| `VOICEMODE_CONCH_LOCK_EXPIRY` | `300` | ロック自動解除秒数 |

### HTTPサーバー / Connect
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_SERVE_HOST` | `127.0.0.1` | バインドアドレス |
| `VOICEMODE_SERVE_PORT` | `8765` | ポート |
| `VOICEMODE_SERVE_TRANSPORT` | `streamable-http` | プロトコル |
| `VOICEMODE_CONNECT_ENABLED` | `false` | リモート接続 |
| `VOICEMODE_CONNECT_WS_URL` | `wss://voicemode.dev/ws` | WebSocket URL |
| `VOICEMODE_AGENT_NAME` | 空 | エージェント名 |
| `VOICEMODE_HOST_ALIAS` | 空 | ホスト別名 |

### 認証・セキュリティ
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `OPENAI_API_KEY` | なし | OpenAI APIキー |
| `VOICEMODE_SERVE_ALLOW_LOCAL` | `true` | ローカル接続許可 |
| `VOICEMODE_SERVE_ALLOW_ANTHROPIC` | `false` | Anthropic IP許可 |
| `VOICEMODE_SERVE_ALLOW_TAILSCALE` | `false` | Tailscale IP許可 |
| `VOICEMODE_SERVE_ALLOWED_IPS` | 空 | 追加許可CIDR |
| `VOICEMODE_SERVE_SECRET` | 空 | URLシークレットパス |
| `VOICEMODE_SERVE_TOKEN` | 空 | Bearerトークン |
| `VOICEMODE_CREDENTIAL_STORE` | `keyring` | 資格情報保存先（`keyring`/`plaintext`） |

### イベントログ
| 変数名 | デフォルト | 説明 |
|---|---|---|
| `VOICEMODE_EVENT_LOG_ENABLED` | `true` | イベントログ有効化 |
| `VOICEMODE_EVENT_LOG_DIR` | `~/.voicemode/logs/events` | ログ保存先 |
| `VOICEMODE_EVENT_LOG_ROTATION` | `daily` | ローテーション |
