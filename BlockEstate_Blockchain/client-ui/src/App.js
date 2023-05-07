import { Routes, Route, Link } from 'react-router-dom';
import { Layout, Typography, Avatar } from 'antd';
import { Navbar, Login, Signup, Homepage, AddEmployee, EmployeeList, AddPrivateData, ShowPrivateData } from './components';

import './App.css';
import icon from './images/logo.png';

const App = () => {
  return (
    <div className='app'>
      <div className='logo-container'>
      <Avatar src={icon} size="large" />
        <Typography.Title level={2} className="logo">
          <Link to="/">Magic Blocks
          </Link>
        </Typography.Title>
        <div className='header-nav-bar'>
        <Navbar headerIcon={true}/>
        </div>
      </div>
      <div className='navbar'>
        <Navbar headerIcon={false}/>
      </div>
      <div className='main'>
        <Layout>
          <div className="routes">
            <Routes>
              <Route path='/' element={<Homepage />} />
              <Route path='/login' element={<Login />} />
              <Route path='/signup' element={<Signup />} />
              <Route path='/addemployee' element={<AddEmployee/>}/>
              <Route path='/employeelist' element={<EmployeeList/>}/>
              <Route path='/privatedata' element={<AddPrivateData/>}/>
              <Route path='/showemppvtdata' element={<ShowPrivateData/>}/>
              <Route path='/logout' element={<Login />} />
            </Routes>
          </div>
        </Layout>
       
      </div>
      <div className="footer">
          <Typography.Title level={5} style={{ color: 'white', textAlign: 'center',fontSize:'12px'}}>
            HyperLedger Team @Kmit <br />
          </Typography.Title>
        </div>
    </div>

  );
}

export default App;