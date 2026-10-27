# Smart Topup Android — APK Starter

এই প্রজেক্টটি Android WebView অ্যাপের সোর্স প্রজেক্ট। কমলা থিমে Free Fire ও PUBG Mobile, লগইন/সাইনআপ, প্যাকেজ, Add Money, অর্ডার হিস্ট্রি ও অ্যাডমিন স্ক্রিনের প্রাথমিক কার্যপ্রবাহ আছে।

## গুরুত্বপূর্ণ সীমা
- এটি **সোর্স প্রজেক্ট**, আগে থেকে তৈরি/সাইন করা APK নয়।
- `app/src/main/assets/config.js`-এ Supabase URL ও public anon/publishable key বসালে authentication/database সংযোগ চালু হবে।
- Supabase কনফিগার না থাকলে UI-তে ডেমো মোড দেখাবে; ডেমো অর্ডার বাস্তব পেমেন্ট বা ডায়মন্ড পাঠায় না।
- `service_role` বা Secret key কখনো অ্যাপে বসাবেন না।
- bKash/Nagad নম্বরটি পেমেন্ট গ্রহণের নির্দেশনা হিসেবে দেখানো যায়; শুধু Transaction ID দিলেই টাকা যাচাই হয় না। অ্যাডমিনকে লেনদেন যাচাই করতে হবে।
- বাস্তব গেম টপ-আপের জন্য অনুমোদিত সরবরাহকারী/API এবং নিরাপদ সার্ভার-সাইড integration লাগবে। এই প্রজেক্ট নিজে ডায়মন্ড/UC পাঠায় না।

## শুধু Android ফোন দিয়ে APK তৈরি
1. ZIP extract করুন।
2. GitHub-এ নতুন repository তৈরি করুন।
3. ZIP-এর ভেতরের ফাইলগুলো repository-তে আপলোড করুন (ZIP ফাইলটি একা নয়)।
4. GitHub-এর **Actions** ট্যাব খুলুন। `Build Smart Topup APK` workflow চালান।
5. কাজ সফল হলে workflow run-এর নিচে `SmartTopup-debug-apk` artifact ডাউনলোড করুন।
6. ZIP artifact extract করে APK ইনস্টল করুন। Android চাইলে Settings থেকে এই ফাইলের জন্য install permission দিন।

## Supabase সেটআপ
1. Supabase project তৈরি করুন।
2. SQL Editor-এ `supabase/schema.sql` চালান।
3. `app/src/main/assets/config.js`-এ Project URL ও public anon/publishable key বসান।
4. Supabase Auth-এ Email provider চালু রাখুন। Production-এ email confirmation এবং password reset সেটআপ করুন।
5. Admin role নিরাপদে দিতে হবে; `profiles.role` ব্যবহারকারীর নিজের কাছ থেকে পরিবর্তনযোগ্য করে দেবেন না। নিচের SQL-এ RLS আছে, তবে বাস্তব admin assignment trusted server/dashboard থেকে করতে হবে।

## পেমেন্ট নম্বর
`config.js`-এ `PAYMENT_NUMBER` বদলান। বর্তমান নম্বরটি আগের কথোপকথনে দেওয়া নম্বর হিসেবে বসানো হয়েছে; সেটি bKash ও Nagad—দুটোতেই সক্রিয় কিনা যাচাই করুন।

## ফোল্ডার
- `app/` — Android WebView app ও UI
- `supabase/schema.sql` — database schema ও RLS
- `.github/workflows/android.yml` — cloud APK build workflow

বাস্তব টাকা নেওয়ার আগে staging-এ পরীক্ষা করুন এবং পেমেন্ট/অর্ডার অনুমোদন সার্ভার-সাইডে যাচাই করুন।
