from admob import FullScreenAd, PyFullScreenContentDelegate, GADFullScreenPresentingAd
from admob import BannerAd, PyBannerViewDelegate, GADBannerView

import kivy
kivy.require('2.1.0') # replace with your current kivy version !

from kivy.app import App
from kivy.lang import Builder
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

class FullScreenAdCallback:
    def adDidRecordClick(self, ad: GADFullScreenPresentingAd):
        print("adDidRecordClick")

    def adDidRecordImpression(self, ad: GADFullScreenPresentingAd):
        print("adDidRecordImpression")

    def adDidDismissFullScreenContent(self, ad: GADFullScreenPresentingAd):
        print("adDidDismissFullScreenContent")

    def adWillDismissFullScreenContent(self, ad: GADFullScreenPresentingAd):
        print("adWillDismissFullScreenContent")

    def adWillPresentFullScreenContent(self, ad: GADFullScreenPresentingAd):
        print("adWillPresentFullScreenContent")

    def didFailToPresentFullScreenContent(self, ad: GADFullScreenPresentingAd, error: str):
        print("didFailToPresentFullScreenContent", error)

class BannerViewAdCallback:
    def bannerViewDidReceiveAd(self, bannerView: GADBannerView):
        print("bannerViewDidReceiveAd")

    def bannerViewDidRecordClick(self, bannerView: GADBannerView):
        print("bannerViewDidRecordClick")

    def bannerViewDidRecordImpression(self, bannerView: GADBannerView):
        print("bannerViewDidRecordImpression")

    def bannerViewDidDismissScreen(self, bannerView: GADBannerView):
        print("bannerViewDidDismissScreen")

    def bannerViewWillDismissScreen(self, bannerView: GADBannerView):
        print("bannerViewWillDismissScreen")

    def bannerViewWillPresentScreen(self, bannerView: GADBannerView):
        print("bannerViewWillPresentScreen")

    def bannerView(self, bannerView: GADBannerView, error: str):
        print("bannerViewerror")


Builder.load_string("""
<MainView>:
    ToggleButton:
        text: "Banner Ad"
        on_state: app.toggle_banner(self.state)
    Button:
        text: "Trigger Fullscreen Ad"
        on_release: app.trigger_full_ad()
""")

class MainView(BoxLayout):
    ...



class MyApp(App):

    def __init__(self, **kwargs):
        super(MyApp, self).__init__(**kwargs)
        
        #interstitial ad
        self.fullscreen_ad = FullScreenAd("ca-app-pub-3940256099942544/1033173712")
        self.fs_callback = FullScreenAdCallback()
        self.fullscreen_delegate = PyFullScreenContentDelegate(self.fs_callback)

        #banner ad
        self.banner_ad = BannerAd("ca-app-pub-3940256099942544/2934735716", 160)
        self.banner_callback = BannerViewAdCallback()
        self.banner_delegate = PyBannerViewDelegate(self.banner_callback)

    def build(self):
        return MainView()

    def trigger_full_ad(self):
        self.fullscreen_ad.show(self.fullscreen_delegate)

    def toggle_banner(self, state):
        if state == "down":
            self.banner_ad.show(self.banner_delegate)
        else:
            self.banner_ad.disable()


if __name__ == '__main__':
    MyApp().run()