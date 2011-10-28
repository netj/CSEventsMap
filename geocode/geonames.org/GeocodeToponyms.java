import java.io.*;
import org.geonames.*;

public class GeocodeToponyms {
    public static void main(String[] args) throws Exception {
        if (args.length == 0) {
            System.out.println("geonames.org geocoder");
            System.out.println("Usage: GeocodeToponyms USERNAME [FILE]");
        }
        WebService.setUserName(args[0]);
        Reader r;
        if (args.length > 1)
            r = new FileReader(new File(args[1]));
        else
            r = new InputStreamReader(System.in);
        BufferedReader in = new BufferedReader(r);
        while (in.ready()) {
            String name = in.readLine();

            ToponymSearchCriteria searchCriteria = new ToponymSearchCriteria();
            searchCriteria.setQ(name);
            ToponymSearchResult searchResult = WebService.search(searchCriteria);
            for (Toponym toponym : searchResult.getToponyms()) {
                System.out.println(
                        name
                        +"\t"+ toponym.getLatitude()
                        +"\t"+ toponym.getLongitude()
                        +"\t"+ toponym.getName()
                        +"\t"+ toponym.getCountryName()
                        );
                break;
            }
        }
        in.close();
    }
}
