import React from 'react';
import AppLayout from '../components/layout/AppLayout';
import DashboardLayout from '../components/layout/DashboardLayout';

const DashboardHome = () => {
    return (
        <AppLayout>
            <DashboardLayout>
                <h1>Dashboard Home Page</h1>
            </DashboardLayout>
        </AppLayout>
    );
};

export default DashboardHome;
