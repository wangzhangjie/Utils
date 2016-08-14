//
//  utils.swift
//  Utils
//
//  Created by wangzhangjie on 15/12/14.
//  Copyright © 2016年 wangzhangjie. All rights reserved.
//
import UIKit

public extension Int{
    /**转为String*/
    var toString : String{
        return NumberToString(self)
    }
    /**转为CGFloat*/
    var toCGFloat : CGFloat{
        return CGFloat(self)
    }
    /**转为Float*/
    var toFloat : Float{
        return Float(self)
    }
    /**转为double*/
    var toDouble : Double{
        return Double(self)
    }
}

public extension Double{
    /**转为CGFloat*/
    var toCGFloat : CGFloat {
        return CGFloat(self)
    }
    
    /**转为String*/
    var toString : String{
        return NumberToString(self)
    }
}

public extension Float{
    
    /**转为CGFloat*/
    public var toCGFloat : CGFloat {
        return CGFloat(self)
    }
    /**转为String*/
    public var toString : String{
        return NumberToString(self)
    }
}

public extension CGFloat{
    
    /**转为String*/
    public var toString : String{
        return NumberToString(self)
    }
    /**转为double型*/
    public var toDouble : Double {
        return Double(self)
    }
}

public extension String{
        /**成功则返回值，失败返回－99999*/
        public var toDouble :Double{
            return Double(self) ?? -99999
        }
        /**成功则返回值，失败返回－99999*/
        public var toFloat :Float{
            return Float(self) ?? -99999
        }
        /**string转CGFloat,请注意float本身的精度。6位精度内无损失**/
        public var toCGFloat : CGFloat{
            return CGFloat(self.toFloat)
        }
    public func trim() -> String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    /**字符串专为字符数组*/
    public func toArray() -> [Character]{
        var myarray : [Character] = []
        for char in self.characters {
            myarray.append(char)
        }
        if myarray.count > 0 {
            return myarray
        }else{
            return []
        }
    }
    /**转为int*/
    public var toInt : Int {
        return Int(self)!
    }
    /**base64编码*/
    public func base64() -> String {
        //NSASCIIStringEncoding
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = data?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String!
    }
    /**base64解码*/
    public func base64Decode() -> String {
        let data = NSData(base64EncodedString: self, options: .IgnoreUnknownCharacters)
        let oriString = String(data: data!, encoding: NSUTF8StringEncoding)
        return oriString!
    }
    
//    public func sha1() -> String {
//        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
//        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
//        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joinWithSeparator("")
//    }
    /**10禁止*/
    public static func changeToInt(num:String) -> Int {
        let str = num.uppercaseString
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
    /**通过字符串得到对应颜色。参数可为#3d5f6a,或0x2d3a5b等*/
    public func colorWithHexColorString(hexColorString : String) ->UIColor{
        
        if hexColorString.characters.count < 6{
            return UIColor.blackColor()
        }
        
        var tmpString = hexColorString.lowercaseString
        
        if tmpString.hasPrefix("0x"){
            
            tmpString = tmpString.substringFromIndex(tmpString.startIndex.advancedBy(2))
            
        }else if(tmpString.hasPrefix("#")){
            
            tmpString = tmpString.substringFromIndex(tmpString.startIndex.advancedBy(1))
        }
        
        if tmpString.characters.count != 6{
            return UIColor.blackColor()
        }
        
        let rString = tmpString.substringWithRange(Range<String.Index>(tmpString.startIndex ..< tmpString.startIndex.advancedBy(2)))
        
        let gString = tmpString.substringWithRange(Range<String.Index>(tmpString.startIndex.advancedBy(2) ..< tmpString.startIndex.advancedBy(4)))
        
        let bString = tmpString.substringWithRange(Range<String.Index>(tmpString.startIndex.advancedBy(4) ..< tmpString.startIndex.advancedBy(6)))
        
        let r =  String.changeToInt(rString)
        let g =  String.changeToInt(gString)
        let b =  String.changeToInt(bString)
        
        return UIColor(red: r.toCGFloat/255.0, green: g.toCGFloat/255.0, blue: b.toCGFloat/255.0, alpha: 1.0)
        
        
    }
    /**中间数字变为＊＊＊＊*/
    public mutating func toSecury() -> String{
        
        self.replaceRange(Range(self.startIndex.advancedBy(3) ..< self.startIndex.advancedBy(7)), with: "****")
        return self
    }
    public mutating func toSecuryPersonNumber() -> String{
        
        self.replaceRange(Range(self.startIndex.advancedBy(1) ..< self.startIndex.advancedBy(14)), with: "************")
        return self
    }
}
/**转字符串*/
public func NumberToString<T>(a : T) ->String{
    
    switch a {
    case is Int     : return String(a)
    case is Double  : return String(a)
    case is Float   : return String(a)
    case is CGFloat : return String(a)
    case is String  : return a as! String
    default         : return "NumberToString()的参数必须非空为数字类型或者字符串"
    }
}
/**获取颜色*/
public func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


public let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0


/**屏幕宽*/
public let kScreenWidth                = UIScreen.mainScreen().bounds.size.width
/**屏幕高*/
public let kScreenHeight               = UIScreen.mainScreen().bounds.size.height

/**以6为标准，适配各机型的宽度*/
public func ALD(x: CGFloat) -> CGFloat{
    return (x * kScreenWidth/375.0)
}

public func ALD(x: Int) -> CGFloat{
    return (CGFloat(x) * kScreenWidth/375.0)
}

extension String {
    /**验证是否为有效身份证()*/
    public func validatePersonNumber() -> Bool {
        //去除空格
        guard self.characters.count == 18 else{
            
            return false
        }
        
        let lastnumber : Character = self.characters.last!
        
        guard String(lastnumber).rangeOfString("^[0-9Xx]$", options: .RegularExpressionSearch, range: nil, locale: nil) != nil else{
            
            return false
        }
        
        let forward17 : String = self.substringWithRange(Range<Index>(self.startIndex.advancedBy(0) ..< self.startIndex.advancedBy(17) ))
        
        guard forward17.rangeOfString("^[0-9]{17}$", options: .RegularExpressionSearch, range: nil, locale: nil) != nil else{
            
            return false
        }
        
        let area = "(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)"
        let year = "(19[0-9]+|20[0-1][0-6])"
        let mm = "(0[1-9]|1[0-2])"
        let dd = "(0[1-9]|[1-2][0-9]|[3][0-1])"
        
        let forwardTwo : String = self.substringWithRange(Range<Index>(self.startIndex.advancedBy(0) ..< self.startIndex.advancedBy(2)))
        
        guard forwardTwo.rangeOfString(area, options: .RegularExpressionSearch, range: nil, locale: nil)
            != nil else {
                
                return false
        }
        
        let birthyear : String = self.substringWithRange(Range<Index>(self.startIndex.advancedBy(6) ..< self.startIndex.advancedBy(10)))
        
        guard birthyear.rangeOfString(year, options: .RegularExpressionSearch, range: nil, locale: nil)
            != nil  else{
                
                return false
        }
        
        let birthMonth : String = self.substringWithRange(Range<Index>(self.startIndex.advancedBy(10) ..< self.startIndex.advancedBy(12)))
        
        guard birthMonth.rangeOfString(mm, options: .RegularExpressionSearch, range: nil, locale: nil)
            != nil  else{
                
                return false
        }
        
        let birthDay : String = self.substringWithRange(Range<Index>(self.startIndex.advancedBy(12) ..< self.startIndex.advancedBy(14)))
        
        guard birthDay.rangeOfString(dd, options: .RegularExpressionSearch, range: nil, locale: nil)
            != nil  else{
                
                return false
        }
        
        guard !(birthDay == "29" && birthyear.toInt % 4 != 0) else{
            //校验 闰年
            
            return false
        }
        
        let chars = self.uppercaseString.toArray()
        
        let sum : Int = (chars[0].toInt + chars[10].toInt) * 7
            + (chars[1].toInt + chars[11].toInt) * 9
            + (chars[2].toInt + chars[12].toInt) * 10
            + (chars[3].toInt + chars[13].toInt) * 5
            + (chars[4].toInt + chars[14].toInt) * 8
            + (chars[5].toInt + chars[15].toInt) * 4
            + (chars[6].toInt + chars[16].toInt) * 2
            + chars[7].toInt
            + chars[8].toInt * 6
            + chars[9].toInt * 3
        
        let yushu = sum % 11
        
        let checkString = "10X98765432"
        
        let checkNumber =  checkString.toArray()[yushu]
        
        return (checkNumber == chars.last)
    }
}

extension Character {
    /**字符转int*/
    var toInt : Int {
        return String(self).toInt
    }
}
