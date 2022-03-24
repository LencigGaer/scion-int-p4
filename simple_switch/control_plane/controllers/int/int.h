#pragma once

#include "controller.h"
#include "kafkaProducer.h"
#include "tcpClient.h"
#include "commonInt.h"
#include "bitstring.h"

#include <p4/v1/p4runtime.pb.h>
#include <p4/v1/p4runtime.grpc.pb.h>
#include <p4/config/v1/p4info.pb.h>

#include <boost/array.hpp>
#include <boost/asio.hpp>
#include <boost/asio/spawn.hpp>
#include <boost/coroutine2/all.hpp>

#include <vector>

void txCntUpdater(boost::asio::io_service &io_service, SwitchConnection& connection, uint32_t counterTxId, boost::asio::yield_context yield_context);

class IntController : public Controller
{
public:
    IntController(SwitchConnection& con, const p4::config::v1::P4Info &p4Info_, boost::asio::io_service &io_service,
        std::string hostASStr, uint32_t nodeId, std::string intTablePath, std::string kafkaAddress, 
        std::string tcpAddress);

public:
    /// \name Stream Message Handlers
    ///@{
    void handleArbitrationUpdate(
        SwitchConnection &con, const p4::v1::MasterArbitrationUpdate& arbUpdate) override;
    bool handlePacketIn(SwitchConnection& con, const p4::v1::PacketIn& packetIn) override;
    ///@}
    
private:
    /// \name Initialization Functions
    ///@{
    bool installStaticTableEntries(SwitchConnection &con);
    bool configCloneSession(SwitchConnection &con);
    ///@}
    
    void updateTxUtil();

private:
    p4::config::v1::P4Info p4Info;
    uint32_t nodeID;
    uint64_t hostAS;
    uint16_t hostISD;
    std::vector<uint64_t> asList;
    std::vector<uint16_t> bitmaskIntList;
    std::vector<uint16_t> bitmaskScionList;
    kafkaProducer kafkaProd;  // Used for Kafka topics output
    tcpClient tcpSocket;      // Used for output over tcp port
};
