import React from 'react';
import { Container, Header } from 'semantic-ui-react';
import Search from './Search/Search.jsx';
import { withRouter } from 'react-router';
import FeaturedDestinations from './FeaturedDestinations.jsx';
import mapChart from './utils/mapChart.js';
import axios from 'axios';
import moment from 'moment';


class Home extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      trips: [],
      depart: '',
      arrive: '',
      seats: '',
      date: moment(),
      isLoading: false,
      focused: false
    };
  }

  componentDidMount(){
    this.fetch();
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value }, this.fetch);
    // date => this.setState({ date })
    console.log(e.target.name, e.target.value)
  }

  handleDate(date) {
    console.log("handle date: ", date);
    this.setState({date:date}, this.fetch);
  }

  handleFocus(focused) {
    console.log("focused: ",focused);
    this.setState({focused:focused});
  }

  fetch() {
    const {depart, arrive, seats} = this.state; // date, seats
    const departdate = moment(this.state.date._d).format('YYYY-MM-DD');
    console.log(departdate)
    axios.get('/api/maps', {
      params: { depart, arrive, departdate, seats }
    })
    .then((response) => {
      console.log('resonse inside axios response data', response.data);
      this.setState({
        trips: response.data
      },  function(){mapChart(response.data);});
    })
    .catch(function (error) {
      console.log(error);
    });
  }

  render() {
    return (
      <Container>
        <Header as='h1' id='main-header'>
          Road Tryp
        </Header>
        <Header as='h2' id='main-header2'>
          Go anywhere.
        </Header>
        <Search currentUser={this.props.currentUser} depart={this.state.depart} arrive={this.state.arrive} seats={this.state.seats} handleChange={this.handleChange.bind(this)} date={this.state.date} handleDate={this.handleDate.bind(this)} focused={this.state.focused} handleFocus={this.handleFocus.bind(this)}/>
        <div className="container">
          <div id="chartdiv"></div>
        </div>

        <FeaturedDestinations currentUser={this.props.currentUser}/>
      </Container>
    );
  }
}

export default withRouter(Home);