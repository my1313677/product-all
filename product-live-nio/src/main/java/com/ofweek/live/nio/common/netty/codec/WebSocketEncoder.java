package com.ofweek.live.nio.common.netty.codec;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageEncoder;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;

import java.util.List;


public final class WebSocketEncoder extends MessageToMessageEncoder<String> {

	@Override
	protected void encode(ChannelHandlerContext ctx, String msg, List<Object> out) throws Exception {
		TextWebSocketFrame tws = new TextWebSocketFrame(msg);
		out.add(tws);
	}

}
