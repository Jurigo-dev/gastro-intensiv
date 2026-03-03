# MoodForecaster

MoodForecaster är en Flutter-app för proaktiv mental wellness. Appen kombinerar daglig mood-tracking, offline-first datalagring och AI-baserad prognos för att ge tidiga interventioner.

## Funktioner

### Gratis (MVP)
- Daglig mood-loggning (humör, energi, stress, anteckning).
- Offline-first lagring med `sqflite`.
- AI-liknande riskprognos på enhet (heuristisk modell som kan bytas mot TFLite senare).
- Interventioner för att minska stress proaktivt.
- Tillgänglig UI med stora touch-mål och semantik.

### Premium (förberedd)
- RevenueCat-integration med entitlement `premium`.
- Premium-sektion i dashboard för veckovisa AI-insikter.
- Stöd för uppgradering/paywall-hook.

## Arkitektur
- `lib/models`: Datamodeller (`MoodEntry`, `MoodForecast`).
- `lib/services`: Databas, AI-prognos, prenumeration.
- `lib/repositories`: Repository-lager för testbarhet.
- `lib/providers`: Riverpod state management.
- `lib/screens` + `lib/widgets`: UI och återanvändbara komponenter.

## Setup

1. Installera Flutter 3.24+.
2. Hämta beroenden:
   ```bash
   flutter pub get
   ```
3. (Valfritt) Konfigurera Firebase för iOS/Android och lägg till `google-services.json` / `GoogleService-Info.plist`.
4. (Valfritt) Konfigurera RevenueCat API-nycklar via dart-define:
   ```bash
   flutter run \
     --dart-define=RC_ANDROID_KEY=din_android_nyckel \
     --dart-define=RC_IOS_KEY=din_ios_nyckel
   ```
5. Starta appen:
   ```bash
   flutter run
   ```

## Test

```bash
flutter test
```

## Vidare produktionsteg (rekommenderat)
- Byt heuristisk prognos mot TFLite-modell med on-device feature extraction.
- Integrera wearables (Apple Health / Health Connect) för automatisk sömn- och stegdata.
- Lägg till Firebase Auth + krypterad synk till Firestore.
- Implementera full premium paywall-flow (offerings + purchase + restore).
- Lägg till anonymiserad analytics och A/B-test för retentionmål.
