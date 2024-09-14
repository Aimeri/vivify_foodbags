<p><span style="font-size:20px;"><strong>vivify_foodbags</strong></span><br>Creates a Foodbag item for restaurants to put their food to more easily hand to customers.<br><br><span style="font-size:18px;"><strong>Dependencies</strong></span></p>
<ul>
    <li>QB-Core</li>
    <li>QB-Inventory <em style="box-sizing:border-box;"><i>NEW</i></em></li>
    <li>Interact</li>
</ul>
<p><br><span style="font-size:18px;"><strong>Installation</strong></span></p>
<p>Just drag and drop into your resources folder. For easy setup, drop it into your [standalone] folder.&nbsp;<br>Add the following item to your resources/[qb]/qb-core/shared/items.lua</p>
<pre><code class="language-plaintext">
foodbag = { name = 'foodbag', label = 'Foodbag', weight = 1000, type = 'item', image = 'foodbag.png', unique = true, useable = true, shouldClose = true, description = 'To carry your food around.' },
</code></pre>
<p>Feel free to use the image provided in the IMAGES folder. &nbsp;It's not great though, I'd find another. &nbsp;</p>
<p>Place the image in resources/[qb]/qb-inventory/html/images/</p>
<p>&nbsp;</p>
<p>Then either /refresh and /start vivify_foodbags or restart your server.</p>
<p><br><span style="font-size:18px;"><strong>Configuration</strong></span><br>Just follow the config to add more locations to obtain foodbags.<br><strong>DO NOT just spawn this item in using ‘giveitem’ commands. &nbsp;It requires itemInfo to function properly. &nbsp;Retrieve the items from the interact locations.</strong></p>
