-- AXI-Lite interface signals (simplified)
signal s_axi_awaddr  : std_logic_vector(3 downto 0);
signal s_axi_awvalid : std_logic;
signal s_axi_wdata   : std_logic_vector(31 downto 0);
signal s_axi_wvalid  : std_logic;
signal s_axi_bready  : std_logic;
signal s_axi_araddr  : std_logic_vector(3 downto 0);
signal s_axi_arvalid : std_logic;
signal s_axi_rready  : std_logic;

signal s_axi_awready : std_logic := '0';
signal s_axi_wready  : std_logic := '0';
signal s_axi_bvalid  : std_logic := '0';
signal s_axi_arready : std_logic := '0';
signal s_axi_rvalid  : std_logic := '0';
signal s_axi_rdata   : std_logic_vector(31 downto 0) := (others => '0');

-- Programmable frame length register
signal frame_length_reg : unsigned(31 downto 0) := to_unsigned(1024, 32);

-- AXI-Lite write logic
process(axi_clk)
begin
  if rising_edge(axi_clk) then
    if axi_rst_n = '0' then
      frame_length_reg <= to_unsigned(1024, 32);
      s_axi_awready <= '0';
      s_axi_wready  <= '0';
      s_axi_bvalid  <= '0';
    else
      -- Write address handshake
      if s_axi_awvalid = '1' then
        s_axi_awready <= '1';
      else
        s_axi_awready <= '0';
      end if;

      -- Write data handshake
      if s_axi_wvalid = '1' then
        s_axi_wready <= '1';
        -- Only one register at offset 0x0
        if s_axi_awaddr = "0000" then
          frame_length_reg <= unsigned(s_axi_wdata);
        end if;
        s_axi_bvalid <= '1';
      else
        s_axi_wready <= '0';
        s_axi_bvalid <= '0';
      end if;
    end if;
  end if;
end process;

-- AXI-Lite read logic
process(axi_clk)
begin
  if rising_edge(axi_clk) then
    if axi_rst_n = '0' then
      s_axi_arready <= '0';
      s_axi_rvalid  <= '0';
      s_axi_rdata   <= (others => '0');
    else
      if s_axi_arvalid = '1' then
        s_axi_arready <= '1';
        s_axi_rvalid  <= '1';
        if s_axi_araddr = "0000" then
          s_axi_rdata <= std_logic_vector(frame_length_reg);
        else
          s_axi_rdata <= (others => '0');
        end if;
      else
        s_axi_arready <= '0';
        s_axi_rvalid  <= '0';
      end if;
    end if;
  end if;
end process;
