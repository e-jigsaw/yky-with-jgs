calcDiff = ->
  ultraHappyDay = moment "2011-10-01 +0900", "YYYY-MM-DD Z"
  today = moment()

  diffYear = today.diff(ultraHappyDay, "year")
  diffMonth = today.diff(ultraHappyDay, "month")

  diff =
    year: diffYear
    month: diffMonth - (12 * diffYear)

$(document).ready ->
  diff = calcDiff()
  $("h1").text "#{diff.year}年#{diff.month}ヶ月"
    .addClass "active"
  $("#content").addClass "active"
  $("footer").addClass "active"
