const app = require("express")();
const PORT = process.env.PORT
const API_KEY = process.env.API_KEY

app.listen(
    PORT,
    () => console.log(`Running on http://localhost:${PORT}`))

app.get('/', (req, res) => {
    const LAT = req.query.lat;
    const LONG = req.query.lon;
    
    if(!LAT || !LONG){
        res.status(400).json({msg: "Bad request: Check that \'lat\' and \'lon\' parameters are in the query"})
    } else {
        async function getWeather() {
            try {
                const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LONG}&appid=${API_KEY}`);
                const data = await response.json();
                if (response.status != 200) {
                    res.status(400).json({msg: `Bad request: ${data.message}`})
                } else {
                    res.status(200).json({msg: data}) 
                }
            } catch (error) {
                res.status(502).json({msg: "Bad gateway"})
            }
        };
        getWeather();
    }      
})