class WebViewController < UIViewController
  def loadView
    background = UIColor.blackColor
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    self.view.backgroundColor = background
    webFrame = UIScreen.mainScreen.applicationFrame
    webFrame.origin.y = 0.0
    @webView = UIWebView.alloc.initWithFrame(webFrame)
    @webView.backgroundColor = background
    @webView.scalesPageToFit = true
    @webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
    @webView.delegate = self
    @webView.subviews.each do |sub|
      sub.bounces = false
    end

    loadRequest('http://nathanielbarnes.com')
  end
  
  def wantsFullScreenLayout
    true
  end
  
  def webViewDidFinishLoad(webView)
    self.view.addSubview(@webView)
  end
  
  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    if UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPad
      if interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
        return false
      end
    end
    true
  end
  
  def loadRequest(urlString)
    url = NSURL.URLWithString(urlString)
    request = NSURLRequest.requestWithURL(url)
    @webView.delegate = self
    @webView.loadRequest(request)
  end
end
