//#import "FLXSUtils.h"
//
//static NSString* hexChars = @"0123456789abcdef";
//static const char* digest;
//
//@implementation FLXSUtils
//
//
//
//+(NSString*)combine:(NSString*)s :(NSString*)s1
//{
//    NSString* res=@"";
//    int i=0;
//    while((i<s.length)||(i<s1.length))
//    {
//        res= [res stringByAppendingString:i<s.length? [s substringWithRange:NSMakeRange(i, 1)] :@""];
//        res= [res stringByAppendingString:i<s1.length? [s1 substringWithRange:NSMakeRange(i, 1)]:@""];
//        i++;
//    }
//    res= [res stringByAppendingString: [[NSNumber numberWithInt: [self getRandom:1 :9] ] description]];
//    return res;
//}
//+(int)getRandom:(int)minNum :(int)maxNum
//{
//    return minNum + arc4random() % (maxNum - minNum);
//}
//
//+(NSArray*)breakup:(NSString*)s
//{
//    s=[s substringWithRange :NSMakeRange(0, s.length-1)];
//    NSString* s1=@"";
//    NSString* s2=@"";
//    int i=0;
//    while(i<s.length)
//    {
//        s2 = [s2 stringByAppendingString: [s substringWithRange:NSMakeRange(i, 1)]];
//        i++;
//        if(s1.length<10)
//        {
//            s1=[s1 stringByAppendingString: [s substringWithRange:NSMakeRange(i, 1)]];
//            i++;
//        }
//    }
//    return [[NSArray alloc] initWithObjects:s1,s2,nil];//[s1,s2];
//}
//
//+(NSString*)make10:(NSString*)s
//{
//    NSString* c=@"";
//    while(c.length!=10)
//    {
//       // c+=s.length>c.length?[s charAt:c.length]:[NSString fromCharCode:72];
//
//        c=[c stringByAppendingString: (s.length>c.length?
//                [s substringWithRange:NSMakeRange(c.length, 1)]:
//                @"H"];
//
//    }
//    return c;
//}
//
//+(int)rol:(int)x :(int)n
//{
//    return ( x << n ) | ( (unsigned)x >> ( 32 - n ) );
//}
//
//+(int)ror:(int)x :(int)n
//{
//    int nn = 32 - n;
//    return ( x << nn ) | ( (unsigned)x >> ( 32 - nn ) );
//}
//
//+(NSString*)toHex:(int)n :(BOOL)bigEndian
//{
//    NSString* s = @"";
//    if ( bigEndian )
//    {
//        for ( int i = 0; i < 4; i++ )
//        {
//            s += [hexChars charAt:( ( n >> ( ( 3 - i ) * 8 + 4 ) ) & 0xF )]
//                    + [hexChars charAt:( ( n >> ( ( 3 - i ) * 8 ) ) & 0xF )];
//        }
//    }
//    else
//    {
//        for ( int x = 0; x < 4; x++ )
//        {
//            s += [hexChars charAt:( ( n >> ( x * 8 + 4 ) ) & 0xF )]
//                    + [hexChars charAt:( ( n >> ( x * 8 ) ) & 0xF )];
//        }
//    }
//    return s;
//}
//
//+(NSString*)hash:(NSString*)s
//{
//    return [self hashBinary:[s UTF8String] ];
//}
//
//+(NSString*)hashBytes:(ByteArray*)s
//{
//    return [self hashBinary:s];
//}
//
//+(NSString*)hashBinary:(ByteArray*)s
//{
//    // initialize the md buffers
//    int a = 1732584193;
//    int b = -271733879;
//    int c = -1732584194;
//    int d = 271733878;
//    // variables to store previous values
//    int aa;
//    int bb;
//    int cc;
//    int dd;
//    // create the blocks from the string and
//    // save the length as a local var to reduce
//    // lookup in the loop below
//    NSArray* x = [self createBlocks: s ];
//    int len = [x count];
//    // loop over all of the blocks
//    for ( int i = 0; i < len; i += 16)
//    {
//        // save previous values
//        aa = a;
//        bb = b;
//        cc = c;
//        dd = d;
//        // Round 1
//        a = [self ff:a :b :c :d :(x[((int)(i+ 0))]) :7 :(-680876936)];
//        // 1
//        d = [self ff:d :a :b :c :(x[((int)(i+ 1))]) :12 :(-389564586)];
//        // 2
//        c = [self ff:c :d :a :b :(x[((int)(i+ 2))]) :17 :606105819];
//        // 3
//        b = [self ff:b :c :d :a :(x[((int)(i+ 3))]) :22 :(-1044525330)];
//        // 4
//        a = [self ff:a :b :c :d :(x[((int)(i+ 4))]) :7 :(-176418897)];
//        // 5
//        d = [self ff:d :a :b :c :(x[((int)(i+ 5))]) :12 :1200080426];
//        // 6
//        c = [self ff:c :d :a :b :(x[((int)(i+ 6))]) :17 :(-1473231341)];
//        // 7
//        b = [self ff:b :c :d :a :(x[((int)(i+ 7))]) :22 :(-45705983)];
//        // 8
//        a = [self ff:a :b :c :d :(x[((int)(i+ 8))]) :7 :1770035416];
//        // 9
//        d = [self ff:d :a :b :c :(x[((int)(i+ 9))]) :12 :(-1958414417)];
//        // 10
//        c = [self ff:c :d :a :b :(x[((int)(i+10))]) :17 :(-42063)];
//        // 11
//        b = [self ff:b :c :d :a :(x[((int)(i+11))]) :22 :(-1990404162)];
//        // 12
//        a = [self ff:a :b :c :d :(x[((int)(i+12))]) :7 :1804603682];
//        // 13
//        d = [self ff:d :a :b :c :(x[((int)(i+13))]) :12 :(-40341101)];
//        // 14
//        c = [self ff:c :d :a :b :(x[((int)(i+14))]) :17 :(-1502002290)];
//        // 15
//        b = [self ff:b :c :d :a :(x[((int)(i+15))]) :22 :1236535329];
//        // 16
//        // Round 2
//        a = [self gg:a :b :c :d :(x[((int)(i+ 1))]) :5 :(-165796510)];
//        // 17
//        d = [self gg:d :a :b :c :(x[((int)(i+ 6))]) :9 :(-1069501632)];
//        // 18
//        c = [self gg:c :d :a :b :(x[((int)(i+11))]) :14 :643717713];
//        // 19
//        b = [self gg:b :c :d :a :(x[((int)(i+ 0))]) :20 :(-373897302)];
//        // 20
//        a = [self gg:a :b :c :d :(x[((int)(i+ 5))]) :5 :(-701558691)];
//        // 21
//        d = [self gg:d :a :b :c :(x[((int)(i+10))]) :9 :38016083];
//        // 22
//        c = [self gg:c :d :a :b :(x[((int)(i+15))]) :14 :(-660478335)];
//        // 23
//        b = [self gg:b :c :d :a :(x[((int)(i+ 4))]) :20 :(-405537848)];
//        // 24
//        a = [self gg:a :b :c :d :(x[((int)(i+ 9))]) :5 :568446438];
//        // 25
//        d = [self gg:d :a :b :c :(x[((int)(i+14))]) :9 :(-1019803690)];
//        // 26
//        c = [self gg:c :d :a :b :(x[((int)(i+ 3))]) :14 :(-187363961)];
//        // 27
//        b = [self gg:b :c :d :a :(x[((int)(i+ 8))]) :20 :1163531501];
//        // 28
//        a = [self gg:a :b :c :d :(x[((int)(i+13))]) :5 :(-1444681467)];
//        // 29
//        d = [self gg:d :a :b :c :(x[((int)(i+ 2))]) :9 :(-51403784)];
//        // 30
//        c = [self gg:c :d :a :b :(x[((int)(i+ 7))]) :14 :1735328473];
//        // 31
//        b = [self gg:b :c :d :a :(x[((int)(i+12))]) :20 :(-1926607734)];
//        // 32
//        // Round 3
//        a = [self hh:a :b :c :d :(x[((int)(i+ 5))]) :4 :(-378558)];
//        // 33
//        d = [self hh:d :a :b :c :(x[((int)(i+ 8))]) :11 :(-2022574463)];
//        // 34
//        c = [self hh:c :d :a :b :(x[((int)(i+11))]) :16 :1839030562];
//        // 35
//        b = [self hh:b :c :d :a :(x[((int)(i+14))]) :23 :(-35309556)];
//        // 36
//        a = [self hh:a :b :c :d :(x[((int)(i+ 1))]) :4 :(-1530992060)];
//        // 37
//        d = [self hh:d :a :b :c :(x[((int)(i+ 4))]) :11 :1272893353];
//        // 38
//        c = [self hh:c :d :a :b :(x[((int)(i+ 7))]) :16 :(-155497632)];
//        // 39
//        b = [self hh:b :c :d :a :(x[((int)(i+10))]) :23 :(-1094730640)];
//        // 40
//        a = [self hh:a :b :c :d :(x[((int)(i+13))]) :4 :681279174];
//        // 41
//        d = [self hh:d :a :b :c :(x[((int)(i+ 0))]) :11 :(-358537222)];
//        // 42
//        c = [self hh:c :d :a :b :(x[((int)(i+ 3))]) :16 :(-722521979)];
//        // 43
//        b = [self hh:b :c :d :a :(x[((int)(i+ 6))]) :23 :76029189];
//        // 44
//        a = [self hh:a :b :c :d :(x[((int)(i+ 9))]) :4 :(-640364487)];
//        // 45
//        d = [self hh:d :a :b :c :(x[((int)(i+12))]) :11 :(-421815835)];
//        // 46
//        c = [self hh:c :d :a :b :(x[((int)(i+15))]) :16 :530742520];
//        // 47
//        b = [self hh:b :c :d :a :(x[((int)(i+ 2))]) :23 :(-995338651)];
//        // 48
//        // Round 4
//        a = [self ii:a :b :c :d :(x[((int)(i+ 0))]) :6 :(-198630844)];
//        // 49
//        d = [self ii:d :a :b :c :(x[((int)(i+ 7))]) :10 :1126891415];
//        // 50
//        c = [self ii:c :d :a :b :(x[((int)(i+14))]) :15 :(-1416354905)];
//        // 51
//        b = [self ii:b :c :d :a :(x[((int)(i+ 5))]) :21 :(-57434055)];
//        // 52
//        a = [self ii:a :b :c :d :(x[((int)(i+12))]) :6 :1700485571];
//        // 53
//        d = [self ii:d :a :b :c :(x[((int)(i+ 3))]) :10 :(-1894986606)];
//        // 54
//        c = [self ii:c :d :a :b :(x[((int)(i+10))]) :15 :(-1051523)];
//        // 55
//        b = [self ii:b :c :d :a :(x[((int)(i+ 1))]) :21 :(-2054922799)];
//        // 56
//        a = [self ii:a :b :c :d :(x[((int)(i+ 8))]) :6 :1873313359];
//        // 57
//        d = [self ii:d :a :b :c :(x[((int)(i+15))]) :10 :(-30611744)];
//        // 58
//        c = [self ii:c :d :a :b :(x[((int)(i+ 6))]) :15 :(-1560198380)];
//        // 59
//        b = [self ii:b :c :d :a :(x[((int)(i+13))]) :21 :1309151649];
//        // 60
//        a = [self ii:a :b :c :d :(x[((int)(i+ 4))]) :6 :(-145523070)];
//        // 61
//        d = [self ii:d :a :b :c :(x[((int)(i+11))]) :10 :(-1120210379)];
//        // 62
//        c = [self ii:c :d :a :b :(x[((int)(i+ 2))]) :15 :718787259];
//        // 63
//        b = [self ii:b :c :d :a :(x[((int)(i+ 9))]) :21 :(-343485551)];
//        // 64
//        a += aa;
//        b += bb;
//        c += cc;
//        d += dd;
//    }
//    digest = [[NSData alloc] init] ;
//    [digest writeInt:a];
//    [digest writeInt:b];
//    [digest writeInt:c];
//    [digest writeInt:d];
//    digest.position = 0;
//    // Finish up by concatening the buffers with their hex output
//    return [self toHex: a ] + [self toHex: b ] + [self toHex: c ] + [self toHex: d ];
//}
//
//+(int)f:(int)x :(int)y :(int)z
//{
//    return ( x & y ) | ( (~x) & z );
//}
//
//+(int)g:(int)x :(int)y :(int)z
//{
//    return ( x & z ) | ( y & (~z) );
//}
//
//+(int)h:(int)x :(int)y :(int)z
//{
//    return x ^ y ^ z;
//}
//
//+(int)i:(int)x :(int)y :(int)z
//{
//    return y ^ ( x | (~z) );
//}
//
//+(int)transform:(SEL)func :(int)a :(int)b :(int)c :(int)d :(int)x :(int)s :(int)t
//{
//    int tmp = a + ((int)( [self func:b :c :d] )) + x + t;
//    return [self rol:tmp :s] +  b;
//}
//
//+(int)ff:(int)a :(int)b :(int)c :(int)d :(int)x :(int)s :(int)t
//{
//    return [self transform:f :a :b :c :d :x :s :t];
//}
//
//+(int)gg:(int)a :(int)b :(int)c :(int)d :(int)x :(int)s :(int)t
//{
//    return [self transform:g :a :b :c :d :x :s :t];
//}
//
//+(int)hh:(int)a :(int)b :(int)c :(int)d :(int)x :(int)s :(int)t
//{
//    return [self transform:h :a :b :c :d :x :s :t];
//}
//
//+(int)ii:(int)a :(int)b :(int)c :(int)d :(int)x :(int)s :(int)t
//{
//    return [self transform:i :a :b :c :d :x :s :t];
//}
//
//+(Array*)createBlocks:(ByteArray*)s
//{
//    NSArray* blocks = [[NSArray alloc] init];
//    int len = s.length * 8;
//    int mask = 0xFF;
//    // ignore hi byte of characters > 0xFF
//    for( int i = 0; i < len; i += 8 )
//    {
//        blocks[ ((int)(i >> 5)) ] |= ( s[ i / 8 ] & mask ) << ( i % 32 );
//    }
//    // append padding and length
//    blocks[ ((int)(len >> 5)) ] |= 0x80 << ( len % 32 );
//    blocks[ ((int)(( ( ( len + 64 ) >>> 9 ) << 4 ) + 14)) ] = len;
//    return blocks;
//}
//
//+ (NSString*)hexChars
//{
//    return hexChars;
//}
//+ (ByteArray*)digest
//{
//    return digest;
//}
//@end
//
