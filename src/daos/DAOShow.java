package daos;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DAOShow extends DAO{

	/**
	 * Toma el id de una Play y una lista de Ids de los Shows y genera
	 * en la tabla shows las filas de cada show de la lista (por fecha)
	 * y popula, buscando todos los seats en la tabla seats, la tabla showseat
	 * @param id (Play)
	 * @param datesList (de los shows)
	 * @return
	 */
	public boolean createShowsForPlay(int id, ArrayList<String> datesList, int price){
		Connection conn = connect();
		String sql = "";
		
		//Inserto los shows y recupero sus IDs en showIds
		try {
			PreparedStatement statement;
			int affectedRows;
			ResultSet rs;
			ArrayList<Integer> showIds = new ArrayList<Integer>();
			for(String s: datesList) {
				sql= "INSERT INTO `theatralia`.`show` (`playId`, `date`, `status`) VALUES ('"+id+"', '"+s+"', '1');";
		//		conn.createStatement().executeUpdate(sql); // TODO necesito traer las generated keys para completar la tabla integral
				statement = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
				affectedRows = statement.executeUpdate();
				
				if(affectedRows == 0) {
					done();
					return false;
				}
				else {
					rs = statement.getGeneratedKeys();
					if(rs.next()) {
						System.out.print("ID es= ");System.out.print(rs.getInt(1));
						showIds.add(rs.getInt(1));
					}
				}		
			}
			
		//Consulto por los IDs de los asientos en seatIds
			ArrayList<Integer> seatIds = new ArrayList<Integer>();
			sql = "SELECT seatId FROM theatralia.seat;";
			rs = conn.prepareStatement(sql).executeQuery();
			while(rs.next()) {
				seatIds.add(rs.getInt(1));
			}
		
		//Cargo los ShowSeats			
			for(int showId : showIds) {
				for(int seatId : seatIds) {
					sql= "INSERT INTO `theatralia`.`showseat` (`seatId`, `showId`, `price`) VALUES ('"+seatId+"', '"+showId+"', '"+price+"');";
					System.out.println(sql);
					conn.createStatement().executeUpdate(sql);
				}
			}
			done();	
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			done();
			return false;
		}
	}
	
	/**
	 * Devuelve un resultset con el showId y la fecha del show
	 * @param playId
	 * @return ResultSet o null
	 */
	public ResultSet getShowsForPlay(int playId) {
		Connection conn = connect();
		String sql = "SELECT distinct S.showId, S.`date`, S.status FROM theatralia.`show` S WHERE S.playId = "+playId+";";
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
}
