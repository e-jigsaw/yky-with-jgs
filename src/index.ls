require! {
  moment
}

state =
  num: 0
  get: -> @num
  update: -> if @num is 3 then @num = 0 else @num += 1
activate = (dom)-> dom.setAttribute \class, \active
Toggle = (h1, p, diff)-> ->
  {ultra, marriage} = diff
  switch state.get!
  | 0 =>
    h1.text-content = "#{ultra.year}年#{ultra.month}ヶ月"
    p.text-content = ultra.since
  | 1 =>
    h1.text-content = "#{marriage.year}年#{marriage.month}ヶ月"
    p.text-content = marriage.since
  | 2 =>
    h1.text-content = "#{ultra.day}日"
    p.text-content = ultra.since
  | 3 =>
    h1.text-content = "#{marriage.day}日"
    p.text-content = marriage.since
handler = (toggle)-> ->
  state.update!
  toggle!

ultra-happy-day = moment '2011-10-01 +0900', 'YYYY-MM-DD Z'
marriage-day = moment '2014-10-01 +0900', 'YYYY-MM-DD Z'
today = moment!

diff-year-from-ultra = today.diff ultra-happy-day, \year
diff-month-from-ultra = today.diff ultra-happy-day, \month
diff-day-from-ultra = today.diff ultra-happy-day, \day
diff-year-from-marriage = today.diff marriage-day, \year
diff-month-from-marriage = today.diff marriage-day, \month
diff-day-from-marriage = today.diff marriage-day, \day

diff =
  ultra:
    year: diff-year-from-ultra
    month: diff-month-from-ultra - (12 * diff-year-from-ultra)
    day: diff-day-from-ultra
    since: 'since 2011.10.01'
  marriage:
    year: diff-year-from-marriage
    month: diff-month-from-marriage - (12 * diff-year-from-marriage)
    day: diff-day-from-marriage
    since: 'since 2014.10.01'

h1 = document.getElementsByTagName \h1 .0
document.getElementById \content |> activate
document.getElementsByTagName \footer .0 |> activate
footer-p = document.querySelector 'footer p'
toggle = Toggle h1, footer-p, diff
h1.addEventListener \click, handler toggle
toggle!
