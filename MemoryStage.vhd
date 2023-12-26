LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY MemoryStage IS
    PORT (
        MemWrite : IN STD_LOGIC;
        MemRead : IN STD_LOGIC;
        Call : IN STD_LOGIC;
        INT : IN STD_LOGIC;
        WB_INT : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        Push : IN STD_LOGIC;
        Push_INT_PC : IN STD_LOGIC;
        Push_INT_PC_WB : IN STD_LOGIC;
        Protected_Mem : IN STD_LOGIC;
        IOW : IN STD_LOGIC;
        IOR : IN STD_LOGIC;
        Mem_Init : IN STD_LOGIC;
        ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        R1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Prev_SP : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC_inc : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        IN_Port_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Flags : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Branch_Mem : IN STD_LOGIC;
        Port_Read_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Mem_Read_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Output_Port_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Jump : OUT STD_LOGIC -- Jump to the address in the ALU  
    );
END MemoryStage;

ARCHITECTURE MemoryStageArch OF MemoryStage IS
    COMPONENT MemoryAddressDecoder IS
        PORT (
            ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Prev_SP : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Push : IN STD_LOGIC;
            WB_INT : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Address_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
    END COMPONENT MemoryAddressDecoder;
    COMPONENT WriteDataDecoder IS
        PORT (
            R1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            PC_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Push_INT_PC : IN STD_LOGIC;
            Push_INT_PC_WB : IN STD_LOGIC;
            Call : IN STD_LOGIC;
            write_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT WriteDataDecoder;
    COMPONENT Memory IS
        GENERIC (
            bus_width : INTEGER := 16;
            address_width : INTEGER := 12;
            slot_width : INTEGER := 16
        );
        PORT (
            RST : IN STD_LOGIC;
            WR_EN : IN STD_LOGIC;
            RD_EN : IN STD_LOGIC;
            Address : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0);
            Write_Data : IN STD_LOGIC_VECTOR (bus_width - 1 DOWNTO 0);
            Read_Data : OUT STD_LOGIC_VECTOR (bus_width - 1 DOWNTO 0));
    END COMPONENT Memory;
    COMPONENT IOPort IS
        PORT (
            RESET, OutW, InR : IN STD_LOGIC;
            Write_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data to be written to the output port
            InData : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data from the input port
            Read_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            Output_Port : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)); -- Data read from the input port
    END COMPONENT IOPort;
    SIGNAL write_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Address_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL WR_EN : STD_LOGIC;

BEGIN
    WR_EN <= MemWrite AND (NOT Protected_Mem);
    Jump <= Branch_Mem AND Flags(0);
    WDD : WriteDataDecoder PORT MAP(
        R1 => R1,
        PC_inc => PC_inc,
        Flags => Flags,
        Push_INT_PC => Push_INT_PC,
        Push_INT_PC_WB => Push_INT_PC_WB,
        Call => Call,
        write_data_out => write_data_out);
    MAD : MemoryAddressDecoder PORT MAP(
        ALU_Res => ALU_Res,
        Prev_SP => Prev_SP,
        Push => Push,
        WB_INT => WB_INT,
        RST => RST,
        Address_out => Address_out);
    MEM : Memory GENERIC MAP(
        bus_width => 32,
        address_width => 12,
        slot_width => 16
    )
    PORT MAP(
        RST => Mem_Init,
        WR_EN => WR_EN,
        RD_EN => MemRead,
        Address => Address_out,
        Write_Data => write_data_out,
        Read_Data => Mem_Read_Data);
    IOP : IOPort PORT MAP(
        RESET => RST,
        OutW => IOW,
        InR => IOR,
        Write_Data => ALU_Res,
        InData => IN_Port_Data,
        Read_Data => Port_Read_Data,
        Output_Port => Output_Port_Data);

END MemoryStageArch;