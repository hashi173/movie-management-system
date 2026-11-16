package unittest;

import java.time.LocalDate;
import org.junit.Assert;
import org.junit.Test;
import dao.CustomerStatisticDAO;
import dao.MemberDAO;
import dao.MovieDAO;
import dao.TransactionDAO;
import model.CustomerStatistic;
import model.ManagementStaff;
import model.Movie;
import model.Transaction;

public class TestCinemaDAO {

    private final MovieDAO movieDAO = new MovieDAO();
    private final MemberDAO memberDAO = new MemberDAO();
    private final CustomerStatisticDAO customerStatisticDAO = new CustomerStatisticDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Test
    public void testSearchMovies_Chuan() {
        Movie[] movies = movieDAO.searchMovies("The Odyssey");
        Assert.assertNotNull(movies);
        Assert.assertEquals(2, movies.length);
    }

    @Test
    public void testSearchMovies_NgoaiLeKhongCoPhim() {
        Movie[] movies = movieDAO.searchMovies("PhimKhongTonTaiXYZ999");
        Assert.assertNotNull(movies);
        Assert.assertEquals(0, movies.length);
    }

    @Test
    public void testGetMovieDetail_Chuan() {
        Movie movie = movieDAO.getMovieDetail("MV78");
        Assert.assertNotNull(movie);
        Assert.assertEquals("The Odyssey", movie.getTitle());
        Assert.assertEquals("Christopher Nolan", movie.getDirector());
        Assert.assertEquals(173, movie.getDuration());
    }

    @Test
    public void testCheckLogin_Chuan() {
        ManagementStaff staff = memberDAO.checkLogin("staffa", "123456");
        Assert.assertNotNull(staff);
        Assert.assertEquals("staffa", staff.getUsername());
    }

    @Test
    public void testCheckLogin_SaiMatKhau() {
        ManagementStaff staff = memberDAO.checkLogin("staffa", "wrongpass");
        Assert.assertNull(staff);
    }

    @Test
    public void testGetCustomerStatisticsByRevenue_Chuan() {
        LocalDate start = LocalDate.of(2026, 7, 1);
        LocalDate end = LocalDate.of(2026, 7, 30);
        CustomerStatistic[] stats = customerStatisticDAO.getCustomerStatisticsByRevenue(start, end);
        Assert.assertNotNull(stats);
        Assert.assertEquals(2, stats.length);
        Assert.assertEquals("KH98", stats[0].getCustomerCode());
        Assert.assertEquals(1000000L, stats[0].getTotalAmount().longValue());
    }

    @Test
    public void testGetTransactionsByCustomer_Chuan() {
        LocalDate start = LocalDate.of(2026, 7, 1);
        LocalDate end = LocalDate.of(2026, 7, 30);
        Transaction[] trans = transactionDAO.getTransactionsByCustomer("KH98", start, end);
        Assert.assertNotNull(trans);
        Assert.assertEquals(2, trans.length);
        Assert.assertEquals("GD1", trans[0].getTransactionCode());
        Assert.assertEquals("GD2", trans[1].getTransactionCode());
    }
}
