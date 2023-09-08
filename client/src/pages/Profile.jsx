import { Contract } from 'ethers';
import React,{useState,useEffect} from 'react';
import {useStateContext} from '../context';
import {DisplayCampaigns} from '../components';

const Profile = () => {
   const [isLoading, setIsLoading]=useState(false);
   const [campaigns,setCampaigns]=useState([]);
   const {address,contract, getUserCampaigns}=useStateContext();
    const fetchCampaigns=async ()=>{
      setIsLoading(true);
      const data=await getUserCampaigns();
      setCampaigns(data);
      setIsLoading(false);
    }
  
   useEffect(()=>{
    if(Contract)fetchCampaigns();

   },[address,contract]);
  return (
    <DisplayCampaigns
     title="All campaigns"
     isLoading={isLoading}
     campaigns={campaigns}

    />
  )
}

export default Profile