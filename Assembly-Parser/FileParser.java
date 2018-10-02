import java.io.*;

public class FileParser {

	public static int i_10, i_follow, r_follow;

	public String getOpcode(String s) {
		String bitsOut = "";
		switch (s) {

		case "ah":
			bitsOut = String.format("%11s", Integer.toBinaryString(200)).replace(" ", "0");
			break;
		case "ahi":
			bitsOut = String.format("%8s", Integer.toBinaryString(29)).replace(" ", "0");
			i_10 = 1;
			break;
		case "a":
			bitsOut = String.format("%11s", Integer.toBinaryString(192)).replace(" ", "0");
			break;
		case "ai":
			bitsOut = String.format("%8s", Integer.toBinaryString(28)).replace(" ", "0");
			i_10 = 1;
			break;
		case "sf":
			bitsOut = String.format("%11s", Integer.toBinaryString(64)).replace(" ", "0");
			break;
		case "sfi":
			bitsOut = String.format("%8s", Integer.toBinaryString(13)).replace(" ", "0");
			i_10 = 1;
			break;
		case "addx":
			bitsOut = String.format("%11s", Integer.toBinaryString(832)).replace(" ", "0");
			break;
		case "cg":
			bitsOut = String.format("%11s", Integer.toBinaryString(194)).replace(" ", "0");
			break;
		case "sfx":
			bitsOut = String.format("%11s", Integer.toBinaryString(833)).replace(" ", "0");
			break;
		case "bg":
			bitsOut = String.format("%11s", Integer.toBinaryString(66)).replace(" ", "0");
			break;
		case "mpy":
			bitsOut = String.format("%11s", Integer.toBinaryString(964)).replace(" ", "0");
			break;
		case "mpya":
			bitsOut = String.format("%4s", Integer.toBinaryString(12)).replace(" ", "0");
			break;
		case "mpyh":
			bitsOut = String.format("%11s", Integer.toBinaryString(965)).replace(" ", "0");
			break;
		case "mpys":
			bitsOut = String.format("%11s", Integer.toBinaryString(967)).replace(" ", "0");
			break;
		case "mpyhh":
			bitsOut = String.format("%11s", Integer.toBinaryString(966)).replace(" ", "0");
			break;
		case "clz":
			bitsOut = String.format("%11s", Integer.toBinaryString(677)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "cntb":
			bitsOut = String.format("%11s", Integer.toBinaryString(692)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "fsmb":
			bitsOut = String.format("%11s", Integer.toBinaryString(438)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "fsmbi":
			bitsOut = String.format("%9s", Integer.toBinaryString(101)).replace(" ", "0");
			break;
		case "absdb":
			bitsOut = String.format("%11s", Integer.toBinaryString(83)).replace(" ", "0");
			break;
		case "avgb":
			bitsOut = String.format("%11s", Integer.toBinaryString(211)).replace(" ", "0");
			break;
		case "sumb":
			bitsOut = String.format("%11s", Integer.toBinaryString(595)).replace(" ", "0");
			break;
		case "xshw":
			bitsOut = String.format("%11s", Integer.toBinaryString(686)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "and":
			bitsOut = String.format("%11s", Integer.toBinaryString(705)).replace(" ", "0");
			break;
		case "andi":
			bitsOut = String.format("%8s", Integer.toBinaryString(20)).replace(" ", "0");
			i_10 = 1;
			break;
		case "or":
			bitsOut = String.format("%11s", Integer.toBinaryString(713)).replace(" ", "0");
			break;
		case "ori":
			bitsOut = String.format("%8s", Integer.toBinaryString(4)).replace(" ", "0");
			i_10 = 1;
			break;
		case "xor":
			bitsOut = String.format("%11s", Integer.toBinaryString(577)).replace(" ", "0");
			break;
		case "nand":
			bitsOut = String.format("%11s", Integer.toBinaryString(201)).replace(" ", "0");
			break;
		case "selb":
			bitsOut = String.format("%4s", Integer.toBinaryString(8)).replace(" ", "0");
			break;
		case "shlh":
			bitsOut = String.format("%11s", Integer.toBinaryString(95)).replace(" ", "0");
			break;
		case "shl":
			bitsOut = String.format("%11s", Integer.toBinaryString(91)).replace(" ", "0");
			break;
		case "roth":
			bitsOut = String.format("%11s", Integer.toBinaryString(92)).replace(" ", "0");
			break;
		case "ceq":
			bitsOut = String.format("%11s", Integer.toBinaryString(960)).replace(" ", "0");
			break;
		case "cgt":
			bitsOut = String.format("%11s", Integer.toBinaryString(576)).replace(" ", "0");
			break;
		case "ceqi":
			bitsOut = String.format("%8s", Integer.toBinaryString(124)).replace(" ", "0");
			i_10 = 1;
			break;
		case "cgti":
			bitsOut = String.format("%8s", Integer.toBinaryString(76)).replace(" ", "0");
			i_10 = 1;
			break;
		case "dfa":
			bitsOut = String.format("%11s", Integer.toBinaryString(716)).replace(" ", "0");
			break;
		case "dfs":
			bitsOut = String.format("%11s", Integer.toBinaryString(709)).replace(" ", "0");
			break;
		case "dfm":
			bitsOut = String.format("%11s", Integer.toBinaryString(718)).replace(" ", "0");
			break;
		case "dfceq":
			bitsOut = String.format("%11s", Integer.toBinaryString(963)).replace(" ", "0");
			break;
		case "dfma":
			bitsOut = String.format("%11s", Integer.toBinaryString(860)).replace(" ", "0");
			break;
		case "dfcqt":
			bitsOut = String.format("%11s", Integer.toBinaryString(707)).replace(" ", "0");
			break;

		case "br":
			bitsOut = String.format("%9s", Integer.toBinaryString(100)).replace(" ", "0");
			i_follow = 1;
			break;
		case "bra":
			bitsOut = String.format("%9s", Integer.toBinaryString(96)).replace(" ", "0");
			i_follow = 1;
			break;
		case "brsl":
			bitsOut = String.format("%9s", Integer.toBinaryString(102)).replace(" ", "0");
			break;
		case "brasl":
			bitsOut = String.format("%9s", Integer.toBinaryString(98)).replace(" ", "0");
			break;
		case "bi":
			bitsOut = String.format("%11s", Integer.toBinaryString(424)).replace(" ", "0") + ("xxxxxxx");
			r_follow = 1;
			break;
		case "brz":
			bitsOut = String.format("%9s", Integer.toBinaryString(70)).replace(" ", "0");
			break;
		case "brnz":
			bitsOut = String.format("%9s", Integer.toBinaryString(68)).replace(" ", "0");
			break;
		case "biz":
			bitsOut = String.format("%11s", Integer.toBinaryString(296)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "binz":
			bitsOut = String.format("%11s", Integer.toBinaryString(297)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "lqx":
			bitsOut = String.format("%11s", Integer.toBinaryString(452)).replace(" ", "0");
			break;
		case "lqa":
			bitsOut = String.format("%9s", Integer.toBinaryString(97)).replace(" ", "0");
			break;
		case "lqr":
			bitsOut = String.format("%9s", Integer.toBinaryString(103)).replace(" ", "0");
			break;
		case "stqx":
			bitsOut = String.format("%11s", Integer.toBinaryString(324)).replace(" ", "0");
			break;
		case "stqa":
			bitsOut = String.format("%9s", Integer.toBinaryString(65)).replace(" ", "0");
			break;
		case "stqr":
			bitsOut = String.format("%9s", Integer.toBinaryString(71)).replace(" ", "0");
			break;
		case "ilh":
			bitsOut = String.format("%9s", Integer.toBinaryString(131)).replace(" ", "0");
			break;
		case "ilhu":
			bitsOut = String.format("%9s", Integer.toBinaryString(130)).replace(" ", "0");
			break;
		case "il":
			bitsOut = String.format("%9s", Integer.toBinaryString(129)).replace(" ", "0");
			break;
		case "iohl":
			bitsOut = String.format("%9s", Integer.toBinaryString(193)).replace(" ", "0");
			break;
		case "shlqbi":
			bitsOut = String.format("%11s", Integer.toBinaryString(475)).replace(" ", "0");
			break;
		case "shlqby":
			bitsOut = String.format("%11s", Integer.toBinaryString(479)).replace(" ", "0");
			break;
		case "rotqby":
			bitsOut = String.format("%11s", Integer.toBinaryString(476)).replace(" ", "0");
			break;
		case "rotqbi":
			bitsOut = String.format("%11s", Integer.toBinaryString(472)).replace(" ", "0");
			break;
		case "gbb":
			bitsOut = String.format("%11s", Integer.toBinaryString(434)).replace(" ", "0") + ("xxxxxxx");
			break;
		case "stop":
			bitsOut = String.format("%11s", Integer.toBinaryString(0)).replace(" ", "0") + ("xxxxxxxxxxxxxxxxxxxxx");
			break;
			
		case "R0":
			bitsOut = String.format("%7s", Integer.toBinaryString(0)).replace(" ", "0");
			break;
		case "R1":
			bitsOut = String.format("%7s", Integer.toBinaryString(1)).replace(" ", "0");
			break;
		case "R2":
			bitsOut = String.format("%7s", Integer.toBinaryString(2)).replace(" ", "0");
			break;
		case "R3":
			bitsOut = String.format("%7s", Integer.toBinaryString(3)).replace(" ", "0");
			break;
		case "R4":
			bitsOut = String.format("%7s", Integer.toBinaryString(4)).replace(" ", "0");
			break;
		case "R5":
			bitsOut = String.format("%7s", Integer.toBinaryString(5)).replace(" ", "0");
			break;
		case "R6":
			bitsOut = String.format("%7s", Integer.toBinaryString(6)).replace(" ", "0");
			break;
		case "R7":
			bitsOut = String.format("%7s", Integer.toBinaryString(7)).replace(" ", "0");
			break;
		case "R8":
			bitsOut = String.format("%7s", Integer.toBinaryString(8)).replace(" ", "0");
			break;
		case "R9":
			bitsOut = String.format("%7s", Integer.toBinaryString(9)).replace(" ", "0");
			break;
		case "R10":
			bitsOut = String.format("%7s", Integer.toBinaryString(10)).replace(" ", "0");
			break;
		case "R11":
			bitsOut = String.format("%7s", Integer.toBinaryString(11)).replace(" ", "0");
			break;
		case "R12":
			bitsOut = String.format("%7s", Integer.toBinaryString(12)).replace(" ", "0");
			break;
		case "R13":
			bitsOut = String.format("%7s", Integer.toBinaryString(13)).replace(" ", "0");
			break;
		case "R14":
			bitsOut = String.format("%7s", Integer.toBinaryString(14)).replace(" ", "0");
			break;
		case "R15":
			bitsOut = String.format("%7s", Integer.toBinaryString(15)).replace(" ", "0");
			break;
		case "R16":
			bitsOut = String.format("%7s", Integer.toBinaryString(16)).replace(" ", "0");
			break;
		case "R17":
			bitsOut = String.format("%7s", Integer.toBinaryString(17)).replace(" ", "0");
			break;
		case "R18":
			bitsOut = String.format("%7s", Integer.toBinaryString(18)).replace(" ", "0");
			break;
		case "R19":
			bitsOut = String.format("%7s", Integer.toBinaryString(19)).replace(" ", "0");
			break;
		case "R20":
			bitsOut = String.format("%7s", Integer.toBinaryString(20)).replace(" ", "0");
			break;
		case "R21":
			bitsOut = String.format("%7s", Integer.toBinaryString(21)).replace(" ", "0");
			break;
		case "R22":
			bitsOut = String.format("%7s", Integer.toBinaryString(22)).replace(" ", "0");
			break;
		case "R23":
			bitsOut = String.format("%7s", Integer.toBinaryString(23)).replace(" ", "0");
			break;
		case "R24":
			bitsOut = String.format("%7s", Integer.toBinaryString(24)).replace(" ", "0");
			break;
		case "R25":
			bitsOut = String.format("%7s", Integer.toBinaryString(25)).replace(" ", "0");
			break;
		case "R26":
			bitsOut = String.format("%7s", Integer.toBinaryString(26)).replace(" ", "0");
			break;
		case "R27":
			bitsOut = String.format("%7s", Integer.toBinaryString(27)).replace(" ", "0");
			break;
		case "R28":
			bitsOut = String.format("%7s", Integer.toBinaryString(28)).replace(" ", "0");
			break;
		case "R29":
			bitsOut = String.format("%7s", Integer.toBinaryString(29)).replace(" ", "0");
			break;
		case "R30":
			bitsOut = String.format("%7s", Integer.toBinaryString(30)).replace(" ", "0");
			break;
		case "R31":
			bitsOut = String.format("%7s", Integer.toBinaryString(31)).replace(" ", "0");
			break;
		case "R32":
			bitsOut = String.format("%7s", Integer.toBinaryString(32)).replace(" ", "0");
			break;
		case "R33":
			bitsOut = String.format("%7s", Integer.toBinaryString(33)).replace(" ", "0");
			break;
		case "R34":
			bitsOut = String.format("%7s", Integer.toBinaryString(34)).replace(" ", "0");
			break;
		case "R35":
			bitsOut = String.format("%7s", Integer.toBinaryString(35)).replace(" ", "0");
			break;
		case "R36":
			bitsOut = String.format("%7s", Integer.toBinaryString(36)).replace(" ", "0");
			break;
		case "R37":
			bitsOut = String.format("%7s", Integer.toBinaryString(37)).replace(" ", "0");
			break;
		case "R38":
			bitsOut = String.format("%7s", Integer.toBinaryString(38)).replace(" ", "0");
			break;
		case "R39":
			bitsOut = String.format("%7s", Integer.toBinaryString(39)).replace(" ", "0");
			break;
		case "R40":
			bitsOut = String.format("%7s", Integer.toBinaryString(40)).replace(" ", "0");
			break;
		case "R41":
			bitsOut = String.format("%7s", Integer.toBinaryString(41)).replace(" ", "0");
			break;
		case "R42":
			bitsOut = String.format("%7s", Integer.toBinaryString(42)).replace(" ", "0");
			break;
		case "R43":
			bitsOut = String.format("%7s", Integer.toBinaryString(43)).replace(" ", "0");
			break;
		case "R44":
			bitsOut = String.format("%7s", Integer.toBinaryString(44)).replace(" ", "0");
			break;
		case "R45":
			bitsOut = String.format("%7s", Integer.toBinaryString(45)).replace(" ", "0");
			break;
		case "R46":
			bitsOut = String.format("%7s", Integer.toBinaryString(46)).replace(" ", "0");
			break;
		case "R47":
			bitsOut = String.format("%7s", Integer.toBinaryString(47)).replace(" ", "0");
			break;
		case "R48":
			bitsOut = String.format("%7s", Integer.toBinaryString(48)).replace(" ", "0");
			break;
		case "R49":
			bitsOut = String.format("%7s", Integer.toBinaryString(49)).replace(" ", "0");
			break;
		case "R50":
			bitsOut = String.format("%7s", Integer.toBinaryString(50)).replace(" ", "0");
			break;
		case "R51":
			bitsOut = String.format("%7s", Integer.toBinaryString(51)).replace(" ", "0");
			break;
		case "R52":
			bitsOut = String.format("%7s", Integer.toBinaryString(52)).replace(" ", "0");
			break;
		case "R53":
			bitsOut = String.format("%7s", Integer.toBinaryString(53)).replace(" ", "0");
			break;
		case "R54":
			bitsOut = String.format("%7s", Integer.toBinaryString(54)).replace(" ", "0");
			break;
		case "R55":
			bitsOut = String.format("%7s", Integer.toBinaryString(55)).replace(" ", "0");
			break;
		case "R56":
			bitsOut = String.format("%7s", Integer.toBinaryString(56)).replace(" ", "0");
			break;
		case "R57":
			bitsOut = String.format("%7s", Integer.toBinaryString(57)).replace(" ", "0");
			break;
		case "R58":
			bitsOut = String.format("%7s", Integer.toBinaryString(58)).replace(" ", "0");
			break;
		case "R59":
			bitsOut = String.format("%7s", Integer.toBinaryString(59)).replace(" ", "0");
			break;
		case "R60":
			bitsOut = String.format("%7s", Integer.toBinaryString(60)).replace(" ", "0");
			break;
		case "R61":
			bitsOut = String.format("%7s", Integer.toBinaryString(61)).replace(" ", "0");
			break;
		case "R62":
			bitsOut = String.format("%7s", Integer.toBinaryString(62)).replace(" ", "0");
			break;
		case "R63":
			bitsOut = String.format("%7s", Integer.toBinaryString(63)).replace(" ", "0");
			break;
		case "R64":
			bitsOut = String.format("%7s", Integer.toBinaryString(64)).replace(" ", "0");
			break;
		case "R65":
			bitsOut = String.format("%7s", Integer.toBinaryString(65)).replace(" ", "0");
			break;
		case "R66":
			bitsOut = String.format("%7s", Integer.toBinaryString(66)).replace(" ", "0");
			break;
		case "R67":
			bitsOut = String.format("%7s", Integer.toBinaryString(67)).replace(" ", "0");
			break;
		case "R68":
			bitsOut = String.format("%7s", Integer.toBinaryString(68)).replace(" ", "0");
			break;
		case "R69":
			bitsOut = String.format("%7s", Integer.toBinaryString(69)).replace(" ", "0");
			break;
		case "R70":
			bitsOut = String.format("%7s", Integer.toBinaryString(70)).replace(" ", "0");
			break;
		case "R71":
			bitsOut = String.format("%7s", Integer.toBinaryString(71)).replace(" ", "0");
			break;
		case "R72":
			bitsOut = String.format("%7s", Integer.toBinaryString(72)).replace(" ", "0");
			break;
		case "R73":
			bitsOut = String.format("%7s", Integer.toBinaryString(73)).replace(" ", "0");
			break;
		case "R74":
			bitsOut = String.format("%7s", Integer.toBinaryString(74)).replace(" ", "0");
			break;
		case "R75":
			bitsOut = String.format("%7s", Integer.toBinaryString(75)).replace(" ", "0");
			break;
		case "R76":
			bitsOut = String.format("%7s", Integer.toBinaryString(76)).replace(" ", "0");
			break;
		case "R77":
			bitsOut = String.format("%7s", Integer.toBinaryString(77)).replace(" ", "0");
			break;
		case "R78":
			bitsOut = String.format("%7s", Integer.toBinaryString(78)).replace(" ", "0");
			break;
		case "R79":
			bitsOut = String.format("%7s", Integer.toBinaryString(79)).replace(" ", "0");
			break;
		case "R80":
			bitsOut = String.format("%7s", Integer.toBinaryString(80)).replace(" ", "0");
			break;
		case "R81":
			bitsOut = String.format("%7s", Integer.toBinaryString(81)).replace(" ", "0");
			break;
		case "R82":
			bitsOut = String.format("%7s", Integer.toBinaryString(82)).replace(" ", "0");
			break;
		case "R83":
			bitsOut = String.format("%7s", Integer.toBinaryString(83)).replace(" ", "0");
			break;
		case "R84":
			bitsOut = String.format("%7s", Integer.toBinaryString(84)).replace(" ", "0");
			break;
		case "R85":
			bitsOut = String.format("%7s", Integer.toBinaryString(85)).replace(" ", "0");
			break;
		case "R86":
			bitsOut = String.format("%7s", Integer.toBinaryString(86)).replace(" ", "0");
			break;
		case "R87":
			bitsOut = String.format("%7s", Integer.toBinaryString(87)).replace(" ", "0");
			break;
		case "R88":
			bitsOut = String.format("%7s", Integer.toBinaryString(88)).replace(" ", "0");
			break;
		case "R89":
			bitsOut = String.format("%7s", Integer.toBinaryString(89)).replace(" ", "0");
			break;
		case "R90":
			bitsOut = String.format("%7s", Integer.toBinaryString(90)).replace(" ", "0");
			break;
		case "R91":
			bitsOut = String.format("%7s", Integer.toBinaryString(91)).replace(" ", "0");
			break;
		case "R92":
			bitsOut = String.format("%7s", Integer.toBinaryString(92)).replace(" ", "0");
			break;
		case "R93":
			bitsOut = String.format("%7s", Integer.toBinaryString(93)).replace(" ", "0");
			break;
		case "R94":
			bitsOut = String.format("%7s", Integer.toBinaryString(94)).replace(" ", "0");
			break;
		case "R95":
			bitsOut = String.format("%7s", Integer.toBinaryString(95)).replace(" ", "0");
			break;
		case "R96":
			bitsOut = String.format("%7s", Integer.toBinaryString(96)).replace(" ", "0");
			break;
		case "R97":
			bitsOut = String.format("%7s", Integer.toBinaryString(97)).replace(" ", "0");
			break;
		case "R98":
			bitsOut = String.format("%7s", Integer.toBinaryString(98)).replace(" ", "0");
			break;
		case "R99":
			bitsOut = String.format("%7s", Integer.toBinaryString(99)).replace(" ", "0");
			break;
		case "R100":
			bitsOut = String.format("%7s", Integer.toBinaryString(100)).replace(" ", "0");
			break;
		case "R101":
			bitsOut = String.format("%7s", Integer.toBinaryString(101)).replace(" ", "0");
			break;
		case "R102":
			bitsOut = String.format("%7s", Integer.toBinaryString(102)).replace(" ", "0");
			break;
		case "R103":
			bitsOut = String.format("%7s", Integer.toBinaryString(103)).replace(" ", "0");
			break;
		case "R104":
			bitsOut = String.format("%7s", Integer.toBinaryString(104)).replace(" ", "0");
			break;
		case "R105":
			bitsOut = String.format("%7s", Integer.toBinaryString(105)).replace(" ", "0");
			break;
		case "R106":
			bitsOut = String.format("%7s", Integer.toBinaryString(106)).replace(" ", "0");
			break;
		case "R107":
			bitsOut = String.format("%7s", Integer.toBinaryString(107)).replace(" ", "0");
			break;
		case "R108":
			bitsOut = String.format("%7s", Integer.toBinaryString(108)).replace(" ", "0");
			break;
		case "R109":
			bitsOut = String.format("%7s", Integer.toBinaryString(109)).replace(" ", "0");
			break;
		case "R110":
			bitsOut = String.format("%7s", Integer.toBinaryString(110)).replace(" ", "0");
			break;
		case "R111":
			bitsOut = String.format("%7s", Integer.toBinaryString(111)).replace(" ", "0");
			break;
		case "R112":
			bitsOut = String.format("%7s", Integer.toBinaryString(112)).replace(" ", "0");
			break;
		case "R113":
			bitsOut = String.format("%7s", Integer.toBinaryString(113)).replace(" ", "0");
			break;
		case "R114":
			bitsOut = String.format("%7s", Integer.toBinaryString(114)).replace(" ", "0");
			break;
		case "R115":
			bitsOut = String.format("%7s", Integer.toBinaryString(115)).replace(" ", "0");
			break;
		case "R116":
			bitsOut = String.format("%7s", Integer.toBinaryString(116)).replace(" ", "0");
			break;
		case "R117":
			bitsOut = String.format("%7s", Integer.toBinaryString(117)).replace(" ", "0");
			break;
		case "R118":
			bitsOut = String.format("%7s", Integer.toBinaryString(118)).replace(" ", "0");
			break;
		case "R119":
			bitsOut = String.format("%7s", Integer.toBinaryString(119)).replace(" ", "0");
			break;
		case "R120":
			bitsOut = String.format("%7s", Integer.toBinaryString(120)).replace(" ", "0");
			break;
		case "R121":
			bitsOut = String.format("%7s", Integer.toBinaryString(121)).replace(" ", "0");
			break;
		case "R122":
			bitsOut = String.format("%7s", Integer.toBinaryString(122)).replace(" ", "0");
			break;
		case "R123":
			bitsOut = String.format("%7s", Integer.toBinaryString(123)).replace(" ", "0");
			break;
		case "R124":
			bitsOut = String.format("%7s", Integer.toBinaryString(124)).replace(" ", "0");
			break;
		case "R125":
			bitsOut = String.format("%7s", Integer.toBinaryString(125)).replace(" ", "0");
			break;
		case "R126":
			bitsOut = String.format("%7s", Integer.toBinaryString(126)).replace(" ", "0");
			break;
		case "R127":
			bitsOut = String.format("%7s", Integer.toBinaryString(127)).replace(" ", "0");
			break;
		default:
			if (i_10 == 1) {
				bitsOut = String.format("%10s", Integer.toBinaryString(Integer.decode(s))).replace(" ", "0");
			} else {
				if (i_follow == 1) {
					bitsOut = String.format("%16s", Integer.toBinaryString(Integer.decode(s))).replace(" ", "0")
							+ ("xxxxxxx");
				} else {
					bitsOut = String.format("%16s", Integer.toBinaryString(Integer.decode(s))).replace(" ", "0");
				}
			}
			break;
		}

		return bitsOut;
	}

	public static void main(String[] args) throws Exception {

		FileParser obj = new FileParser();

		File file = new File("src/assembly.asm");
		Writer outfile = new FileWriter("C:/Users/kewal/Desktop/Spring 18/ESE 545 Comp Arch/Project/Project/bitstream.txt");

		BufferedReader br = new BufferedReader(new FileReader(file));

		String st;

		while ((st = br.readLine()) != null) {

			i_10 = 0;
			i_follow = 0;
			r_follow = 0;
			String bits = "";
			String line[] = st.split("\\W");

			bits = obj.getOpcode(line[0]);

			if (bits.compareTo("1000") == 1 || bits.compareTo("1100") == 1) {
				
				bits = bits.concat(obj.getOpcode(line[1]));
				bits = bits.concat(obj.getOpcode(line[3]));
				bits = bits.concat(obj.getOpcode(line[2]));
				bits = bits.concat(obj.getOpcode(line[4]));
					
			} else {

				for (int i = line.length - 1; i > 0; i--) {

					// System.out.println(line[i]);

					bits = bits.concat(obj.getOpcode(line[i]));

				}
				if (r_follow == 1) {
					bits = bits + ("xxxxxxx");
				}

			}

			System.out.println(bits);
			outfile.write(bits + "\n");

		}

		outfile.close();

	}

}
