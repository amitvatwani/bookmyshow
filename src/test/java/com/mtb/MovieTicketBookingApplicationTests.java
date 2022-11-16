package com.mtb;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.ShowSeat;
import com.mtb.movie.model.Shows;
import com.mtb.movie.repository.MovieRepository;
import com.mtb.movie.repository.ShowRepository;
import com.mtb.movie.repository.ShowSeatRepo;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.model.TheatreSeat;
import com.mtb.theatre.repository.TheatreCityRepository;
import com.mtb.theatre.repository.TheatreRepository;
import com.mtb.theatre.repository.TheatreScreenRepository;
import com.mtb.theatre.repository.TheatreSeatRepository;
import com.mtb.user.model.User;
import com.mtb.user.repository.UserRepository;
import com.mtb.user.service.UserService;

@SpringBootTest
@TestMethodOrder(OrderAnnotation.class)
class MovieTicketBookingApplicationTests {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private TheatreRepository theatreRepo;
	@Autowired
	private TheatreCityRepository theatreCityRepo;
	@Autowired
	private TheatreScreenRepository theatreScreenRepo;
	@Autowired
	private TheatreSeatRepository theatreSeatRepo;
	@Autowired
	private MovieRepository movieRepo;
	@Autowired
	private ShowRepository showRepo;
	@Autowired
	private ShowSeatRepo showSeatRepo;
	@Autowired
	private UserService userService;
	
	
	// USER
	@Test
	@Order(1)
	public void testAddUser() {
		User user = new User();
		user.setUserName("mkm");
		user.setUserEmail("mohidhkm@gmail.com");
		user.setUserMobile("8281595104");
		user.setUserPassword("Mkm@1996");
		userRepo.save(user);
		assertNotNull(userRepo.findById(4).get());
	}

	@Test
	@Order(2)
	public void testUpdateProfile() {
		User user = userRepo.findById(4).get();
		user.setUserName("Mohidh");
		userRepo.save(user);
		assertEquals("Mohidh", userRepo.findById(4).get().getUserName());
	}

	@Test
	@Order(3)
	public void testGetAllUser() {
		List<User> users = userRepo.findAll();
		assertThat(users).size().isGreaterThan(0);
	}

	@Test
	@Order(4)
	public void testUserById() {
		User user = userRepo.findById(4).get();
		assertEquals("Mohidh", user.getUserName());
	}
	
	
	// Theatre
	@Test
	@Order(5)
	public void testaddTheatre() {
		Theatre theatre = new Theatre();
		theatre.setTheatreName("IMAX AAA");
		User user = userRepo.findById(3).get();
		theatre.setUser(user);
		TheatreCity theatreCity = theatreCityRepo.findById(1).get();
		theatre.setTheatreCity(theatreCity);
		theatreRepo.save(theatre);
		assertNotNull(theatreRepo.findById("TR_0049").get());
	}

	@Test
	@Order(6)
	public void testupdateTheatre() {
		Theatre theatre = theatreRepo.findById("TR_0017").get();
		theatre.setTheatreName("PVR");
		theatreRepo.save(theatre);
		assertEquals("Atria", theatreRepo.findById("TR_0017").get().getTheatreName());
	}

	@Test
	@Order(7)
	public void testgetAllTheatres() {
		List<Theatre> theatres = theatreRepo.findAll();
		assertThat(theatres).size().isGreaterThan(0);
	}

	@Test
	@Order(8)
	public void testgetTheatreById() {
		Theatre theatre = theatreRepo.findById("TR_0020").get();
		assertEquals("PVR", theatre.getTheatreName());
	}

	// TheatreScreens
	@Test
	@Order(9)
	public void testaddTheatreScreen() {
		TheatreScreen theatreScreen = new TheatreScreen();
		theatreScreen.setScreenName("Night");
		theatreScreen.setTotalSeats(0);
		Theatre theatre = theatreRepo.findById("TR_0020").get();
		theatreScreen.setTheatre(theatre);
		theatreScreenRepo.save(theatreScreen);
		assertNotNull(theatreScreenRepo.findById("TS_0019").get());
	}

	@Test
	@Order(10)
	public void testupdateTheatreScreen() {
		TheatreScreen theatreScreen = theatreScreenRepo.findById("TS_0014").get();
		theatreScreen.setScreenName("Diamond");
		theatreScreenRepo.save(theatreScreen);
		assertEquals("Diamond", theatreScreenRepo.findById("TS_0014").get().getScreenName());
	}

	@Test
	@Order(11)
	public void testgetAllTheatreScreens() {
		List<TheatreScreen> theatreScreens = theatreScreenRepo.findAll();
		assertThat(theatreScreens).size().isGreaterThan(0);
	}

	// TheatreSeats
	@Test
	@Order(12)
	public void testaddTheatreSeat() {
		TheatreSeat theatreSeat = new TheatreSeat();
		theatreSeat.setPrice(1000);
		theatreSeat.setSeatNumber("D10-GOLD");
		theatreSeat.setSeatType("Diamond");
		TheatreScreen theatreScreen = theatreScreenRepo.findById("TS_0013").get();
		theatreSeat.setTheatreScreen(theatreScreen);
		theatreSeatRepo.save(theatreSeat);
		assertNotNull(theatreSeatRepo.findById("tseat_0523").get());
	}

	@Test
	@Order(13)
	public void testupdateTheatreSeat() {
		TheatreSeat theatreSeat = theatreSeatRepo.findById("tseat_0521").get();
		theatreSeat.setSeatType("XXX");
		theatreSeatRepo.save(theatreSeat);
		assertEquals("XXX", theatreSeatRepo.findById("tseat_0521").get().getSeatType());
	}

	@Test
	@Order(14)
	public void testgetAllTheatreSeats() {
		List<TheatreSeat> theatreSeats = theatreSeatRepo.findAll();
		assertThat(theatreSeats).size().isGreaterThan(0);
	}

	// TheatreCity
	@Test
	@Order(15)
	public void testaddTheatreCity() {
		TheatreCity theatreCity = new TheatreCity();
		theatreCity.setCityId(4);
		theatreCity.setCityName("Patna");
		theatreCity.setState("Bihar");
		theatreCity.setZipcode(800000);
		theatreCityRepo.save(theatreCity);
		assertNotNull(theatreCityRepo.findById(4).get());
	}

	@Test
	@Order(16)
	public void testupdateTheatreCity() {
		TheatreCity theatreCity = theatreCityRepo.findById(4).get();
		theatreCity.setCityName("Pune");
		theatreCityRepo.save(theatreCity);
		assertEquals("Pune", theatreCityRepo.findById(4).get().getCityName());
	}

	@Test
	@Order(17)
	public void testgetAllTheatreCity() {
		List<TheatreCity> theatreCities = theatreCityRepo.findAll();
		assertThat(theatreCities).size().isGreaterThan(0);
	}

	@Test
	@Order(18)
	public void testGetTheatreCitybyId() {
		TheatreCity theatreCity = theatreCityRepo.findById(1).get();
		assertEquals("Mumbai", theatreCity.getCityName());
	}

	// Movie
	@Test
	@Order(19)
	public void testAddMovie() {
		Movie movie = new Movie();
		movie.setMovieTitle("Avatar2");
		movie.setMovieDescription("xyxz");
		movie.setMovieDuration("180");
		movie.setMoviePoster("zxc");
		movie.setMovieLanguage("English");
		movie.setCountry("USA");
		movie.setReleaseDate("10/07/2023");
		movieRepo.save(movie);
		assertNotNull(movieRepo.findById("M_0004").get());

	}

	@Test
	@Order(20)
	public void testUpdateMovie() {
		Movie movie = movieRepo.findById("M_0004").get();
		movie.setMovieTitle("Avatar3");
		movieRepo.save(movie);
		assertEquals("Avatar3", movieRepo.findById("M_0004").get().getMovieTitle());

	}

	@Test
	@Order(21)
	public void testGetAllMovie() {
		List<Movie> movies = movieRepo.findAll();
		assertThat(movies).size().isGreaterThan(0);
	}

	@Test
	@Order(22)
	public void testGetMoviebyId() {
		Movie movie = movieRepo.findById("M_0004").get();
		assertEquals("Avatar3", movie.getMovieTitle());

	}

	// Shows
	@Test
	@Order(23)
	public void testAddShows() {
		Shows show = new Shows();
		show.setShowDate(new Date());
		show.setStartTime("10:00");
		show.setEndTime("1:00");
		Movie movie = movieRepo.findById("M_0003").get();
		show.setMovie(movie);
		TheatreScreen theatreScreen = theatreScreenRepo.findById("TS_0001").get();
		show.setTheatreScreen(theatreScreen);
		showRepo.save(show);
		assertNotNull(showRepo.findById("SH_0002").get());

	}

	@Test
	@Order(24)
	public void testUpdateShow() {
		Shows show = showRepo.findById("SH_0002").get();
		show.setStartTime("11:00");
		showRepo.save(show);
		assertEquals("11:00", showRepo.findById("SH_0002").get().getStartTime());
	}

	@Test
	@Order(25)
	public void testGetAllShows() {
		List<Shows> shows = showRepo.findAll();
		assertThat(shows).size().isGreaterThan(0);
	}

	@Test
	@Order(26)
	public void testGetshowById() {
		Shows show = showRepo.findById("SH_0002").get();
		assertEquals("11:00", show.getStartTime());
	}

	@Test
	@Order(27)
	public void testAddShowSeat() {
		ShowSeat showSeat = new ShowSeat();
		Shows show = showRepo.findById("SH_0002").get();
		showSeat.setShow(show);
		showSeat.setStatus("Available");
		TheatreSeat theatreSeat = theatreSeatRepo.findById("tseat_0050").get();
		showSeat.setTheatreSeat(theatreSeat);
		showSeatRepo.save(showSeat);
		assertNotNull(showSeatRepo.findById("SS_0055").get());
	}

	@Test
	@Order(28)
	public void testUpdateShowSeat() {
		ShowSeat showSeat = showSeatRepo.findById("SS_0055").get();
		showSeat.setStatus("blocked");
		showSeatRepo.save(showSeat);
		assertEquals("blocked", showSeatRepo.findById("SS_0055").get().getStatus());
	}

	@Test
	@Order(29)
	public void testGetAllShowSeatsForShow() {
		Shows show = showRepo.findById("SH_0002").get();
		List<ShowSeat> showSeat = showSeatRepo.findByShow(show);
		assertThat(showSeat).size().isGreaterThan(0);
	}

	@Test
	@Order(30)
	public void testGetShowSeatById() {
		assertEquals("blocked", showSeatRepo.findById("SS_0055").get().getStatus());
	}

	// Delete

	@Test
	public void testdeleteTheatre() {
		theatreRepo.deleteById("TR_0049");
		assertThat(theatreRepo.existsById("TR_0049")).isFalse();
	}

	@Test
	public void testdeleteTheatreScreen() {
		theatreScreenRepo.deleteById("TS_0019");
		assertThat(theatreScreenRepo.existsById("TS_0019")).isFalse();
	}

	@Test
	public void testdeleteTheatreSeat() {
		theatreSeatRepo.deleteById("tseat_0522");
		assertThat(theatreSeatRepo.existsById("tseat_0522")).isFalse();
	}

	@Test
	public void testdeleteCity() {
		theatreCityRepo.deleteById(4);
		assertThat(theatreCityRepo.existsById(4)).isFalse();
	}

	@Test
	public void testDeleteMovie() {
		movieRepo.deleteById("M_0004");
		assertThat(movieRepo.existsById("M_0004")).isFalse();
	}

	@Test
	public void testDeleteById() {
		showRepo.deleteById("SH_0002");
		assertThat(showRepo.existsById("SH_0002")).isFalse();
	}

	public void testShowSeatDeleteById() {
		showSeatRepo.deleteById("SS_0055");
		assertThat(showSeatRepo.existsById("SS_0055")).isFalse();
	}
	
	//Businesslogic_testing
	@Test
	@Order(31)
	public void testsendmail() {
		User user = userRepo.findById(4).get();
		String otp=userService.sendmail(user.getUserEmail());
		assertEquals(6, otp.length());
	}
	
}
