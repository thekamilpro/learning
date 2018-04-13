Function line  {Write-Host "======"}

@()

$fruit = @('Apples','Oranges','Bananas')

$fruit
line
$fruit += 'Strawberries'
$Line
$fruit
line
$fruit.Count

$fruit[0]

$fruit[2]
line
$FruitNEW = $fruit | Where-Object {$_ -ne 'Apples'}

$FruitNEW