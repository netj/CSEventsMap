import java.io.*;
import org.geonames.*;

public class GeocodeToponyms {
    public static void main(String[] args) throws Exception {
        WebService.setUserName("netj");
        BufferedReader r = new BufferedReader(new FileReader(new File(args[0])));
        while (r.ready()) {
            String name = r.readLine();

            ToponymSearchCriteria searchCriteria = new ToponymSearchCriteria();
            searchCriteria.setQ(name);
            ToponymSearchResult searchResult = WebService.search(searchCriteria);
            for (Toponym toponym : searchResult.getToponyms()) {
                System.out.println(
                        name
                        +"\t"+ toponym.getLatitude()
                        +"\t"+ toponym.getLongitude()
                        +"\t"+ toponym.getName() +", "+ toponym.getCountryName()
                        );
                break;
            }
            break;
        }
        r.close();
    }
}
