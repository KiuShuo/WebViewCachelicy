# WebViewCachelicy

然后分析[Demo](https://github.com/KiuShuo/WebViewCachelicy.git)中的代码：

```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        if needClearCache {
            URLCache.shared.removeAllCachedResponses()
        }
        let ip = "172.19.20.210"
        let urlStr = "http://\(ip)/test.txt"
        if let url = URL(string: urlStr) {
            let urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60.0)
            webView.loadRequest(urlRequest)
        }
    }
```
通过上面的代码可以看出，urlRequest的生成中包含了缓存策略参数和超时时间参数，其中的缓存策略参数就决定了WebView的缓存策略。

下面看一下这个枚举类型的缓存策略参数对应的所有常量值以及含义：

``` Swift
extension NSURLRequest {

	public enum CachePolicy : UInt {

        case useProtocolCachePolicy

        case reloadIgnoringLocalCacheData

        case reloadIgnoringLocalAndRemoteCacheData // Unimplemented

        public static var reloadIgnoringCacheData: NSURLRequest.CachePolicy { get }

        case returnCacheDataElseLoad

        case returnCacheDataDontLoad

        case reloadRevalidatingCacheData // Unimplemented
    }
    
}

```

枚举`NSURLRequest.CachePolicy`定义了一些常量，这些常量用来确定请求下来的数据与已有的缓存数据之间的交互（取舍）。  

* 常量`CachePolicy.useProtocolCachePolicy`：url请求加载的默认策略，指定的缓存逻辑位于协议的实现中，用于请求particular（特定的）URL。
* 常量`CachePolicy.reloadIgnoringLocalCacheData`：指定从原始数据源获取数据，无论其新鲜度或有效性都不存在本地缓存数据，用于satisfy（满足）URL加载请求。
* 常量`CachePolicy.reloadIgnoringLocalAndRemoteCacheData`：指定 不仅忽略本地的缓存数据，还忽略代理和其他中间媒介。Unimplemented（未实现的）。
* 常量`CachePolicy.reloadIgnoringCacheData`：是`CachePolicy.reloadIgnoringLocalCacheData`的旧名，即被`CachePolicy.reloadIgnoringLocalCacheData`提换了。
* 常量`CachePolicy.returnCacheDataElseLoad`：指定使用现有的缓存数据来满足URL的加载请求，无论其存在的时间或者过期。如果对应的URL没有缓存数据的话就从数据源获取。
* 常量`CachePolicy.returnCacheDataDontLoad`：指定使用现有的缓存数据来满足URL的加载请求，无论其存在的时间或者过期。如果对应的URL没有缓存数据的话也不从数据源加载该URL，这个请求被设置为失败的。这种情况多用于离线模式。
* 常量`CachePolicy.reloadRevalidatingCacheData`：指定已经存在的缓存数据先去数据源验证其有效性，如果无效的话，将从数据源获取。Unimplemented（未实现的）。

***
想要Demo运行起来还需要如下准备：

1. 开启Apache服务器；
2. 新建一个test.txt文件，里面随便写一段内容；
3. 将test.txt文件copy一份到Apache服务器的文件路径`/Library/WebServer/Documents`下；
4. 将代码中的ip地址改为本机的当前ip；
5. 通过替换Apache服务器文件路径下的text.txt文件来修改其里面的内容。


##[开启本地Apache服务](http://www.jianshu.com/p/90d5fa728861)

```

sudo apachectl start 	// 开启apache
sudo apachectl restart // 重启apache
sudo apachectl stop 	// 关闭apache

// Mac下apache服务器的文件路径
/Library/WebServer/Documents

// 传说中httpd.conf的文件路径，暂时用不到
/private/etc/apache2

```
在同一局域网下，可以使用ip地址来访问本机开启的Apache服务。

