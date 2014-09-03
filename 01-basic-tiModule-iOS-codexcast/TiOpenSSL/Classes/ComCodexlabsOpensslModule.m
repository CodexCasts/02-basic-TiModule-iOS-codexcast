/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComCodexlabsOpensslModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#include <openssl/evp.h>

@implementation ComCodexlabsOpensslModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"fee8cc1a-6284-484c-b231-4cde3062adaa";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.codexlabs.openssl";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

static void ToHex(const unsigned char* data, unsigned int length, char* buffer)
{
	static char hex[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	for (unsigned i = 0; i < length; i++) {
		*buffer++ = hex[(data[i] & 0xf0) >> 4];
		*buffer++ = hex[(data[i] & 0x0f)];
	}
	*buffer = 0;
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}


-(id)cryptoMessage:(NSString*)messageFromTitanium
{
    
    //const char *secretMessage = [ NSString];
    char message[] = "";
    message[0] = messageFromTitanium;
    // NSLog(message[0]);
    //NSLog(messageFromTitanium);
	OpenSSL_add_all_digests();
    
	const EVP_MD* md;
    NSString *secretdigest;
	unsigned char md_value[EVP_MAX_MD_SIZE];
	unsigned int md_len;
	EVP_MD_CTX mdctx;
	
	md = EVP_get_digestbyname("SHA1");
    
	EVP_MD_CTX_init(&mdctx);
	EVP_DigestInit_ex(&mdctx, md, NULL);
	EVP_DigestUpdate(&mdctx, message, strlen(message));
	EVP_DigestFinal_ex(&mdctx, md_value, &md_len);
	EVP_MD_CTX_cleanup(&mdctx);
    
	char md_hex[(EVP_MAX_MD_SIZE * 2) + 1];
	ToHex(md_value, md_len, md_hex);
    
	// example property getter
	secretdigest = [NSString stringWithCString: md_hex encoding: NSASCIIStringEncoding];
    return secretdigest;
}




-(void)setExampleProp:(id)value
{
	// example property setter
}



@end
