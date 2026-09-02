# 🍎 iOS 版打包指南

> 好消息：**iOS 版代码和安卓是同一套**（Flutter 单代码库），`lib/` 里的业务逻辑一行不用改。
> iOS 工程配置（本目录）已经全部就绪，剩下只差「在 Apple 的世界里编译签名」这一步。
> 苹果规定 iOS 应用必须用 macOS 上的 Xcode 编译 —— Windows 电脑做不到，所以有两条路：

## 路线对比

| 路线 | 费用 | 能装到谁的手机 | 适合 |
|---|---|---|---|
| **A. Codemagic 云打包 + AltStore 自签** | 免费（500 分钟/月构建额度 + 免费 Apple ID） | 自己的 iPhone（7 天有效期，过期重签） | 自己用 ✅ 推荐 |
| **B. Codemagic + Apple 开发者账号** | $99/年 | 任何人（TestFlight/上架） | 分发给朋友/上架 |
| C. 借一台 Mac | — | 同 B | 手头有 Mac 的话最简单 |

---

## 路线 A：云打包 + 免费自签（推荐，10 分钟上手）

### 1. 云端出未签名 IPA

1. 注册 [codemagic.io](https://codemagic.io)（用 GitHub 账号登录即可）
2. **Add application** → GitHub → 选 `healthy-diet-app` 仓库
3. 项目类型选 **Flutter App**
4. **Finish** 后进入设置 → Workflow 选 `ios-no-sign`（仓库里的 `codemagic.yaml` 已配好）
5. 点 **Start new build**
6. 3~10 分钟后，构建页 Artifacts 里下载 `litebite-unsigned.ipa`

### 2. 自签安装到 iPhone（需一台 Windows/Mac 电脑 + 数据线）

任选一个免费侧载工具：

- **[Sideloadly](https://sideloadly.io)**（Windows 可用，推荐）
  1. iPhone 连电脑，打开 Sideloadly
  2. 拖入 `litebite-unsigned.ipa`
  3. 输入你的 Apple ID（普通账号即可）→ Start
  4. iPhone 上 设置 → 通用 → VPN与设备管理 → 信任你的开发者证书
  5. 打开 App 🎉（有效期 7 天，到期重复一次第 2~4 步）

- **[AltStore](https://altstore.io)**：装一次后手机自行刷新签名，更省心，但初始配置稍麻烦

> 💡 想免去 7 天重签：$99/年开发者账号走路线 B，或用 AltStore + 备用 Apple ID 自动刷新。

---

## 路线 B：正式签名 / TestFlight / App Store

需要 [Apple Developer Program](https://developer.apple.com/programs/)（$99/年），然后：

1. Codemagic → Teams → 连接你的 App Store Connect（API Key 方式最稳）
2. 仓库里 `codemagic.yaml` 的 `ios-sign` workflow 已写好：
   - 自动拉证书/描述文件
   - 构建 → 签名 → **自动上传 TestFlight**
3. 手机装 TestFlight App，即可安装内测版；积累体验后可提交 App Store 审核

### App Store 上架注意（本项目已备好）

- ✅ `Info.plist`：显示名「轻食记」、区域 `zh_CN`、`ITSAppUsesNonExemptEncryption=false`（免加密合规申报）
- ✅ **零权限申请**（纯离线，无相机/定位/相册/网络），隐私标签可全绿
- ⚠️ 需要自己准备：App 图标 1024×1024（替换 `ios/Runner/Assets.xcassets/AppIcon.appiconset/`，可先用默认 Flutter 图标过 TestFlight）
- ⚠️ 审核需提供：隐私政策 URL + 截图（6.7"/5.5" 两套）；"纯本地无上传"写清楚反而好过审

## 🖥 路线 C：有 Mac 的话

```bash
git clone git@github.com:alexbibihere/healthy-diet-app.git
cd healthy-diet-app
flutter pub get
open ios/Runner.xcworkspace   # Xcode 里选好签名团队，⌘R 直接跑
flutter build ipa             # 或命令行出包
```

## 常见问题

- **Q: Windows 上能验证 iOS 代码能编译吗？** 不能编译，但 `flutter analyze` 全绿 + 安卓构建通过 ≈ 逻辑层无恙；iOS 特有问题（插件兼容）本项目用的 drift/shared_preferences/fl_chart/go_router 全部是 iOS 一等公民，风险很低。
- **Q: Codemagic 免费额度够用几次？** iOS 构建 1 次约 8~15 分钟（M2 机器按分钟计），500 分钟/月 ≈ 30~60 次，个人用绰绰有余。
- **Q: 图标想换成自己的？** 准备 1024×1024 PNG，用 [Appicon.co](https://appicon.co) 生成全套，覆盖 `AppIcon.appiconset/` 后提交，重新构建即可。
