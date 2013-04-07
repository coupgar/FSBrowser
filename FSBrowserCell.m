/*
 Copyright (c) 2011, Stefan Reitshamer http://www.haystacksoftware.com
 
 All rights reserved.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FSBrowserCell.h"

#define CHECKBOX_WIDTH 17.0

@implementation FSBrowserCell

#pragma mark -
#pragma mark Memory related
- (id)init {
    self = [super init];
    [self setLineBreakMode:NSLineBreakByTruncatingTail];
    [self setButtonType:NSSwitchButton];
    [self setAllowsMixedState:YES];
    return self;
}

- (void)dealloc
{
  [_fileIcon release];
  [super dealloc];
}


#pragma mark -
#pragma mark Real magic
- (NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
    NSPoint point = [controlView convertPoint:[event locationInWindow] fromView:nil];
    NSRect checkboxRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, CHECKBOX_WIDTH, cellFrame.size.height);
    NSUInteger ret = NSCellHitNone;
    // If user didn't click the checkbox, return NSCellHitNone; the row will still be selected in the matrix, but the checkbox won't toggle.
    if (NSMouseInRect(point, checkboxRect, [controlView isFlipped])) {
        ret = [super hitTestForEvent:event inRect:cellFrame ofView:controlView];
    }
    return ret;
}

- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView
{
  NSImage * image = nil;
  image = _fileIcon;
  NSRect rect = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.height, frame.size.height);
  [image drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f respectFlipped:YES hints:nil];

  NSRect titleFrame = NSMakeRect(frame.origin.x + 5.0f + frame.size.height, frame.origin.y, frame.size.width - (5.0 + frame.size.height), frame.size.height);
  
  [super drawTitle:title withFrame:titleFrame inView:controlView];
  
  return frame;

}

- (void)setFileIcon:(NSImage *)icon
{
  _fileIcon = [icon retain];
}



@end
