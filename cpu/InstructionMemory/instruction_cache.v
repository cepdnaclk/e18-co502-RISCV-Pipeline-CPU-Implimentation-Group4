// Advanced Computer Architecture (CO502)
// Design: Instruction Cache
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module instruction_cache(
    // Port declaration
    clock, 
    reset, 
    address, 
    readinst, 
    busywait, 
    mem_address, 
    mem_read, 
    mem_readinst, 
    mem_busywait
);

    input [31:0] address;
    input [127:0] mem_readinst;
    input clock, reset, mem_busywait;
    output reg [31:0] readinst;
    output reg busywait;
    output reg [27:0] mem_address;
    output reg mem_read;

    //Create reg arrays in cache
    reg [127:0] inst_cache [0:7];     // Declare instruction cache memory array 128x8-bits
    reg inst_valid [0:7];             // To store valid bit
    reg [24:0] inst_tag [0:7];        // 24 bit tag to store along with every data block

    //set busywait when a pc value is sent to the cache when the address is not -4
    always @ (address)
    begin
        if(address != -32'd4) busywait = 1;
    end
        
    //wires to store the extracted values depending on the index part of the address
    wire valid_out;
    wire [127:0] data_out;
    wire [24:0] tag_out;

    // assign dataout, valid_out & tag_out corresponding to index given by address
    assign #1 data_out = inst_cache[address[6:4]];
    assign #1 valid_out = inst_valid[address[6:4]];
    assign #1 tag_out = inst_tag[address[6:4]];

    wire tag_status, hit;    
    // Check whether tag in corresponding index & tag given by address matches
    assign #1 tag_status = (tag_out == address[31:7]) ? 1 : 0;
    // if tag_status and valid_out is high then its a hit
    assign hit = valid_out & tag_status;

    // If it is a hit, CPU should not be stalled - Set busywait to 0
    always @ (posedge clock)
    begin
        if (hit) busywait = 0;
    end

    // Reading instruction from cache according to the offset, if it is a hit
    always @ (*)
    begin
        #1
        if (hit)
        begin
            case (address[3:2])
                2'b00 : readinst = data_out[31:0];
                2'b01 : readinst = data_out[63:32];
                2'b10 : readinst = data_out[95:64];
                2'b11 : readinst = data_out[127:96];
            endcase
        end
        else 
            readinst = 32'bx;
    end

    /* Cache Controller FSM Start */
    parameter IDLE = 2'b00, READ_MEM = 2'b01, UPDATE_CACHE = 2'b10;
    reg [1:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if (!hit && (address != -32'd4))  
                   next_state = READ_MEM;
                else
                    next_state = IDLE;
                
            READ_MEM:
                if (!mem_busywait)
                    next_state = UPDATE_CACHE;
                else    
                    next_state = READ_MEM;

            UPDATE_CACHE:
                next_state = IDLE;
                
        endcase
    end

    // combinational output logic
    always @(state)
    begin
        case(state)
            IDLE:
                begin
                    mem_read = 0;
                    mem_address = 28'dx;
                end
             
            READ_MEM: 
                begin
                    mem_read = 1;
                    mem_address = {address[31:4]};
                end

            UPDATE_CACHE:
                begin
                    mem_read = 0;
                    #1
                    inst_cache[address[6:4]] = mem_readinst;
                    inst_valid[address[6:4]] = 1;
                    inst_tag[address[6:4]] = address[31:7];
                end
        endcase
    end

    // sequential logic for state transitioning 
    always @ (posedge clock, reset)
    begin
        if(reset)
            state = IDLE;
        else
            state = next_state;
    end
    /* Cache Controller FSM Start */

    // reset instruction cache
    integer i;
    always @ (reset)
    begin
        if(reset)
        begin
            for ( i = 0; i < 8; i = i + 1)
            begin
                inst_valid[i] = 0;
                inst_tag[i] = 25'bx;
                busywait = 0;
                inst_cache[i] = 128'dx;
            end
        end
    end
endmodule