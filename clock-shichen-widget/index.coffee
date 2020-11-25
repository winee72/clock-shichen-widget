stylingOptions =
  # background color
  background: 'rgba(#fff, 0)' 
  # show fullscreen -> true
  fullscreen: false
  # display position 'top', 'middle', 'bottom'
  vertical: 'bottom'

dateOptions =
  # display not only 'time' also 'date'
  showDate: false
  # format of 'date'
  date: '%d/%m/%Y %a'

# chinese shichen
shichenList = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"] 

format = (->
  if dateOptions.showDate
    '%H' + '\n' + '%M' + '\n' + dateOptions.date
  else
    '%H' + '\n' + '%M'
)()

command: "date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

# for update function
dateOptions: dateOptions

render: (output) -> """
  <div id='simpleClock'>#{output}</div>
"""

update: (output) ->
  data = output.split('\n')
  hour = parseInt(data[0])
  if hour >= 23
      hour = 0;
  time = Math.floor((hour+1)/2)
  html = '<div class="shichen">' + shichenList[time] + '<span>时</span></div>'
  html += data[0]
  html += '<span class="minutes">'
  html += data[1]
  html += '</span>'

  if this.dateOptions.showDate

    html += '<span class="date">'
    html += data[2]
    html += '</span>'


  $(simpleClock).html(html)

style: (->
  fontSize = '7em'
  width = 'auto'
  transform = 'auto'
  bottom = '25%'
  top = 'auto'

  if stylingOptions.fullscreen
    fontSize = '10em'
    width = '94%'

  if stylingOptions.vertical is 'middle'
    transform = 'translateY(50%)'
    bottom = '50%'
  else if stylingOptions.vertical is 'top'
    bottom = 'auto'
    top = '3%'

  return """
    background: #{stylingOptions.background}
    color: #FFFFFF
    font-family: Helvetica Neue
    left: 3%
    top: #{top}
    bottom: #{bottom}
    transform: #{transform}
    width: #{width}

    #simpleClock
      font-size: #{fontSize}
      font-weight: 300
      margin: 0
      text-align: left
      padding: 10px 20px

    #simpleClock .date
      display: block
      margin-left: .5em
      margin-top:2em
      font-size: .2em
      font-weight:100
      
    #simpleClock .shichen
      position:absolute
      top:-.9em
      left:0
      font-size:2em
      color:rgba(#fff, 0.2)
      font-weight: 900
      margin:0

    #simpleClock .shichen span      
      position:absolute;
      bottom:0.2em
      left:1.6em
      font-weight: 500
      font-size:100px;

    #simpleClock .minutes
      position:absolute;
      font-weight: 500
      color: #5fdb12
      margin-left: -.5em
      margin-top: .5em
      text-shadow: -5px -3px 10px #000, 5px 0 10px #000
  """
)()
