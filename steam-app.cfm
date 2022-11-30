<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Steam-app</title>
    <link rel="stylesheet" href="./styles.css">
  </head>
  <body>

    <cffile action="read" file="C:\ColdFusion2021\cfusion\wwwroot\src\data.json" variable="data">

    <cfset steamData = deserializeJSON(data)>
    <cfset steamId = "#steamData.steamid#">
    <cfset steamApiKey = "#steamData.apikey#">

    <cfif isDefined("form.steamId")>
      <cfset steamId = form.steamId>
    </cfif>

    <cfhttp result="ownedGames" method="GET" url="https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#steamApiKey#&include_appinfo=true&include_played_free_games=true&steamid=#steamId#&format=json"></cfhttp>
    <cfhttp result="playerSummaries" method="GET" url="https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#steamApiKey#&steamids=#steamId#"></cfhttp>
    
    <cfset ownedGamesData = deserializeJSON("#ownedGames.Filecontent#")>
    <cfset playerSummariesData = deserializeJSON("#playerSummaries.Filecontent#")>
    <cfset gameArray = ownedGamesData.response.games>
    <cfset sortedGameArray = arraySort(gameArray, 
      function (e1, e2){if (e1.playtime_forever > e2.playtime_forever){
          return -1}
        else if (e1.playtime_forever < e2.playtime_forever){
        return 1} else {
          return 0}
          }
    )>

    <cfinclude  template="./navigation.cfm">
    <div class="container">
        <cfset avatar = playerSummariesData.response.players[1].avatarfull>
        <cfset nickname = playerSummariesData.response.players[1].personaname>

        <cfoutput encodeFor="html">
          <div class="user-info">
            <img src="#avatar#">
            <h1>#nickname#</h1>
          </div>
          <cfloop array="#gameArray#" item="item">
            <div class="game-info">
              <img src="http://media.steampowered.com/steamcommunity/public/images/apps/#item.appid#/#item.img_icon_url#.jpg">
              <h3>#item.name#</h3>
              <p>Playtime: #decimalFormat(item.playtime_forever/60)# hours</p> 
            </div>
          </cfloop>
           <!---<cfloop index="i" from="1" to="#arrayLen(gameArray)#">
              <div class="game-info">
                    <img src="http://media.steampowered.com/steamcommunity/public/images/apps/#gameArray[i].appid#/#gameArray[i].img_icon_url#.jpg">
                    <h3>#gameArray[i].name#</h3>
                    <p>Playtime: #decimalFormat(gameArray[i].playtime_forever/60)# hours</p> 
              </div>
          </cfloop>--->
        </cfoutput> 
    </div>
  </body>
</html>
