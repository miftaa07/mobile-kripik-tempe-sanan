class SplashViewModel {
  const SplashViewModel();

  Future<void> waitForIntro() {
    return Future<void>.delayed(const Duration(milliseconds: 2500));
  }
}
