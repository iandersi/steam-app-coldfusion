<div class="navigation">
    <div class="nav-logo"></div>
    <nav>
            <div>Store</div>
            <div>Community</div>
            <div>About</div>
            <div>Support</div>

        <div class="search-bar-container">
            <cfform action="steam-app.cfm" target="_self" method="POST">
             <div class="input-container">
               <cfinput type="text" name="steamId" placeholder="Enter Steam ID...">
               <input type="submit" name="submitId" value="Search">
            </div>
            </cfform>
        </div>
    </nav>
</div>