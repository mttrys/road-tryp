import React from 'react'
import {
  BrowserRouter as Router,
  browserHistory,
  Route,
  Link,
  Switch
} from 'react-router-dom'

import Home from './Home.jsx';
import Login from './Login.jsx';
import Signup from './Signup.jsx';
import NotFound from './NotFound.jsx';
// Each logical "route" has two components, one for
// the sidebar and one for the main area. We want to
// render both of them in different places when the
// path matches the current URL.
const routes = [
  { path: '/',
    exact: true,
    main: Home
  },
  { path: '/login',
    main: Login
  },
  { path: '/signup',
    main: Signup
  },
  {
    path:'*',
    main: NotFound
  }
]

const SidebarExample = () => (
  <Router history={browserHistory}>
    <div>
      <nav>
        <ul>
          <li><Link to="/">Home</Link></li>
          <li><Link to="/login">Login</Link></li>
          <li><Link to="/signup">Sign Up</Link></li>
        </ul>
      </nav>
      <div>
        <Switch>
          {routes.map((route, index) => (
            // Render more <Route>s with the same paths as
            // above, but different components this time.
            <Route
              key={index}
              path={route.path}
              exact={route.exact}
              component={route.main}
            />
          ))}
        </Switch>
      </div>
    </div>
  </Router>
)

export default SidebarExample