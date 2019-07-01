/*******************************************************************************

    Contains the code used for peer-to-peer communication.

    Copyright:
        Copyright (c) 2019 BOS Platform Foundation Korea
        All rights reserved.

    License:
        MIT License. See LICENSE for details.

*******************************************************************************/

module agora.node.GossipProtocol;

import agora.common.Data;
import agora.node.Network;

/// Procedure of peer-to-peer communication
class GossipProtocol 
{
    private NetworkManager network;
    private bool[Hash] receivedMsgCache;

    /// Ctor
    public this (NetworkManager network)
    {
        this.network = network;
    }

    /***************************************************************************

        If this is the first time this message was received, propagate it to the network.
        
        Returns:
           true if this message is new and not a duplicate of a previous message

        Params:
          msg = the received message

    ***************************************************************************/

    public bool receiveMessage(Hash msg) @safe
    {
        if (this.hasMessage(msg))
            return false;

        receivedMsgCache[msg] = true;
        this.network.sendMessage(msg);
        return true;
    }


    /***************************************************************************

        Check if this message is in the message cache.
        
        Returns:
            Return true if this message was a message already received.

        Params:
          msg = the received message

    ***************************************************************************/

    public bool hasMessage(Hash msg) @safe
    {
        return (msg in receivedMsgCache) !is null;
    }

}