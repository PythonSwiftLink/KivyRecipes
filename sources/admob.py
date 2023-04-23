from swift_tools.swift_types import *

@wrapper(py_init=False)
class GADBannerView: ...

@wrapper(new_class=True)
class PyBannerViewDelegate:

    class Callbacks:
        
        @func_options(no_labels={"bannerView":True})
        def bannerViewDidReceiveAd(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidRecordClick(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidRecordImpression(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidDismissScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewWillDismissScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewWillPresentScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True}, args_alias={"error": "didFailToReceiveAdWithError"})
        def bannerView(self, bannerView: GADBannerView, error: Error): ...


@wrapper(py_init=False)
class GADFullScreenPresentingAd: ...

@wrapper(new_class=True)
class PyGADFullScreenContentDelegate:

    class Callbacks:
        
        @func_options(no_labels={"ad":True})
        def adDidRecordClick(ad: GADFullScreenPresentingAd): ...

        @func_options(no_labels={"ad":True})
        def adDidRecordImpression(ad: GADFullScreenPresentingAd): ...

        @func_options(no_labels={"ad":True})
        def adDidDismissFullScreenContent(ad: GADFullScreenPresentingAd): ...

        @func_options(no_labels={"ad":True})
        def adWillDismissFullScreenContent(ad: GADFullScreenPresentingAd): ...

        @func_options(no_labels={"ad":True})
        def adWillPresentFullScreenContent(ad: GADFullScreenPresentingAd): ...

        @func_options(call_target="ad", no_labels={"ad":True}, args_alias={"error": "didFailToPresentFullScreenContentWithError"})
        def didFailToPresentFullScreenContent(ad: GADFullScreenPresentingAd, error: Error): ...


@wrapper
class BannerAd:

    def __init__(self, unit_id: str, height: int): ...

    def show(self, delegate: PyBannerViewDelegate): ...

    def disable(self): ...

@wrapper
class StaticAd:

    def __init__(self, unit_id: str, height: int): ...

    def show(self, delegate: PyBannerViewDelegate): ...

    def disable(self): ...

@wrapper
class FullScreenAd:

    def __init__(self, unit_id: str): ...

    def show(self, delegate: PyGADFullScreenContentDelegate): ...

    def disable(self): ...